//
//  QRScanViewController.swift
//  TicketOil
//
//  Created by Nursat on 09.05.2022.
//

import Foundation
import UIKit
import SnapKit
import AVFoundation

final class QRScanViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: QRScanViewModelProtocol!
    var devicePosition: AVCaptureDevice.Position = .back
    
    private let navigationBarConfigurator: NavigationBarConfigurator
    
    private lazy var captureSession: AVCaptureSession? = {
        let session = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return session }
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            guard session.canAddInput(videoInput) else { return session }
            session.addInput(videoInput)
            
            let metadataOutput = AVCaptureMetadataOutput()
            if session.canAddOutput(metadataOutput) {
                session.addOutput(metadataOutput)
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.qr]
            }
            return session
        } catch {
            self.showAlert(with: "Ошибка", and: error.asUserError.log().localizedDescription)
            return session
        }
    }()
    
    // MARK: - Outlets
    
    private lazy var videoPreviewLayer: AVCaptureVideoPreviewLayer? = {
        let layer = AVCaptureVideoPreviewLayer()
        layer.frame = self.view.bounds
        layer.videoGravity = .resizeAspectFill
        layer.session = captureSession
        return layer
    }()
    
    // MARK: - Actions
    
    private func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        for device in discoverySession.devices {
            if device.position == position {
                return device
            }
        }
        return nil
    }
    
    @objc private func switchCamera() {
        guard let session = captureSession else { return }
        
        devicePosition = devicePosition == .back ? .front : .back
        session.beginConfiguration()
        if let currentCameraInput = session.inputs.first as? AVCaptureDeviceInput {
            session.removeInput(currentCameraInput)
        }
        
        guard let newCamera = cameraWithPosition(position: devicePosition) else { return }
        guard let newInput = try? AVCaptureDeviceInput(device: newCamera),
              session.canAddInput(newInput)
        else { return }
        session.addInput(newInput)
        
        if session.outputs.isEmpty {
            let metadataOutput = AVCaptureMetadataOutput()
            if session.canAddOutput(metadataOutput) {
                session.addOutput(metadataOutput)
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.qr]
            }
        }
        session.outputs.first?.connection(with: .video)?.videoOrientation = .portrait
        session.outputs.first?.connection(with: .video)?.isVideoMirrored = newCamera.position == .front
        session.commitConfiguration()
    }
    
    // MARK: - Lifecycle
    
    init(navigationBarConfigurator: NavigationBarConfigurator) {
        self.navigationBarConfigurator = navigationBarConfigurator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        markup()
        subscribe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
        startSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        captureSession?.stopRunning()
    }
    
    // MARK: - Configurations
    
    private func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        navigationBarConfigurator.configure(
            navigationBar: navigationBar,
            with: .transparent
        )
    }
    
    private func startSession() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            captureSession?.startRunning()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    DispatchQueue.main.async {
                        self.captureSession?.startRunning()
                    }
                }
            }
        default:
            self.showAlert(with: "Разрешение", and: "Требуется разрешение на использование камеры") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    private func subscribe() {
        
    }
    
    // MARK: - Markup
    
    private func markup() {
        view.backgroundColor = .black
        if let layer = videoPreviewLayer {
            view.layer.addSublayer(layer)
        }
    }
}

extension QRScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject],
                        from _: AVCaptureConnection)
    {
        guard let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let qrCode = readableObject.stringValue
        else {
            return
        }
        
        print(qrCode)
        viewModel.handleQrCode(qrCode)
    }
}
