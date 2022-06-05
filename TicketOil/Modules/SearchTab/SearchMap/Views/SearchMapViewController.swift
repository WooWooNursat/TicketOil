//
//  SearchMapViewController.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation
import UIKit
import SnapKit
import YandexMapsMobile
import RxSwift
import RxCocoa
import CoreLocation

final class SearchMapViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: SearchMapViewModelProtocol!
    var disposeBag = DisposeBag()
    
    private let navigationBarConfigurator: NavigationBarConfigurator
    
    // MARK: - Outlets
    
    lazy var mapView: YMKMapView = {
        let view = YMKMapView(frame: .zero, vulkanPreferred: true)!
        view.mapWindow.map.logo.setAlignmentWith(YMKLogoAlignment(horizontalAlignment: .right, verticalAlignment: .top))
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.mapWindow.map.isLiteModeEnabled = true
        view.mapWindow.map.move(
            with: YMKCameraPosition(
                target: .init(
                    latitude: CLLocationCoordinate2D.kbtu.latitude,
                    longitude: CLLocationCoordinate2D.kbtu.longitude
                ),
                zoom: 13.5,
                azimuth: 0,
                tilt: 0
            ),
            animationType: .init(type: .smooth, duration: 0.25),
            cameraCallback: nil
        )
        
        return view
    }()
    
    lazy var userLocationLayer: YMKUserLocationLayer = {
        let layer = YMKMapKit.sharedInstance().createUserLocationLayer(with: mapView.mapWindow)
        layer.setVisibleWithOn(true)
        layer.isHeadingEnabled = true
        return layer
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    // MARK: - Actions
    
    @objc
    private func searchTextFieldEditingChanged(_ textField: UISearchTextField) {
        
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
    }
    
    // MARK: - Configurations
    
    private func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        navigationBarConfigurator.configure(navigationBar: navigationBar)
        let searchResultsVC = GasStationSearchController()
        searchResultsVC.viewModel = viewModel.searchViewModel
        let searchVC = SearchControllerFactory().makeSearchController(searchResultsController: searchResultsVC)
        navigationItem.searchController = searchVC
        searchVC.searchBar.searchTextField.addTarget(self, action: #selector(searchTextFieldEditingChanged), for: .touchUpInside)
    }
    
    private func subscribe() {
        viewModel.isAnimating
            .bind(to: loader.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.gasStations.bind { [weak self] gasStations in
            guard let self = self else { return }
            
            self.mapView.mapWindow.map.mapObjects.clear()
            let collection = self.mapView.mapWindow.map.mapObjects.addClusterizedPlacemarkCollection(with: self)
            gasStations.forEach {
                let placemark = collection.addPlacemark(
                    with: YMKPoint(
                        latitude: $0.location.latitude,
                        longitude: $0.location.longitude
                    ),
                    image: UIImage()
                )
                placemark.userData = $0
                placemark.addTapListener(with: self)
            }
            collection.clusterPlacemarks(withClusterRadius: 30, minZoom: 19)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Markup
    
    private func markup() {
        [mapView, loader].forEach { view.addSubview($0) }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        loader.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
}

extension SearchMapViewController: YMKClusterListener {
    func onClusterAdded(with cluster: YMKCluster) {
        cluster.appearance.setIconWith(clusterImage(cluster.size))
        cluster.addClusterTapListener(with: self)
    }
    
    private var FONT_SIZE: CGFloat { 15 }
    private var MARGIN_SIZE: CGFloat { 3 }
    private var STROKE_SIZE: CGFloat { 3 }
    
    func clusterImage(_ clusterSize: UInt) -> UIImage {
        let scale = UIScreen.main.scale
        let text = (clusterSize as NSNumber).stringValue
        let font = UIFont.systemFont(ofSize: FONT_SIZE * scale)
        let size = text.size(withAttributes: [NSAttributedString.Key.font: font])
        let textRadius = sqrt(size.height * size.height + size.width * size.width) / 2
        let internalRadius = textRadius + MARGIN_SIZE * scale
        let externalRadius = internalRadius + STROKE_SIZE * scale
        let iconSize = CGSize(width: externalRadius * 2, height: externalRadius * 2)
        
        UIGraphicsBeginImageContext(iconSize)
        let ctx = UIGraphicsGetCurrentContext()!
        
        ctx.setFillColor(UIColor(hex: "#D61616")!.cgColor)
        ctx.fillEllipse(in: CGRect(
            origin: .zero,
            size: CGSize(width: 2 * externalRadius, height: 2 * externalRadius)
        ))
        
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillEllipse(in: CGRect(
            origin: CGPoint(x: externalRadius - internalRadius, y: externalRadius - internalRadius),
            size: CGSize(width: 2 * internalRadius, height: 2 * internalRadius)
        ))
        
        (text as NSString).draw(
            in: CGRect(
                origin: CGPoint(x: externalRadius - size.width / 2, y: externalRadius - size.height / 2),
                size: size
            ),
            withAttributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.black,
            ]
        )
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
}

extension SearchMapViewController: YMKClusterTapListener {
    func onClusterTap(with cluster: YMKCluster) -> Bool {
        let gasStations = cluster.placemarks.compactMap { $0.userData as? GasStation }
        let zoom = mapView.mapWindow.map.cameraPosition.zoom
        if gasStations.count > 2 || zoom < 15 {
            let newZoom = min(zoom * 1.2, 17)
            mapView.mapWindow.map.move(
                with: YMKCameraPosition(
                    target: cluster.appearance.geometry,
                    zoom: newZoom,
                    azimuth: 0,
                    tilt: 0
                ),
                animationType: .init(type: .smooth, duration: 0.25),
                cameraCallback: nil
            )
        } else {
            
        }
        
        return true
    }
}

extension SearchMapViewController: YMKMapObjectTapListener {
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        return true
    }
}

extension CLLocationCoordinate2D {
    fileprivate static let kbtu = CLLocationCoordinate2D(latitude: 43.2557, longitude: 76.9432)
}
