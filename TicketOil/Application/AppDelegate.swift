//
//  AppDelegate.swift
//  TicketOil
//
//  Created by Nursat on 17.04.2022.
//

import UIKit
import AVFoundation
import Kingfisher
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?
    
    private let coordinator = DIResolver.resolve(AppCoordinator.self)!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .black
        
        configure()
        
        coordinator.start()
        
        return true
    }
    
    private func configure() {
        configureNavigationBar()
        configureTabBar()
        configureAVPlayback()
        configureImageDownloader()
        configureKeyboardManager()
    }
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold),
        ]
    }
    
    private func configureTabBar() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func configureAVPlayback() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {}
    }
    
    private func configureImageDownloader() {
        // Disk storage images size limit = 5GB
        ImageCache.default.diskStorage.config.sizeLimit = 5368709120
        // Memory storage images size limit = 300MB
        ImageCache.default.memoryStorage.config.totalCostLimit = 314572800
        ImageCache.default.memoryStorage.config.expiration = .seconds(60)
        ImageCache.default.diskStorage.config.expiration = .days(7)
    }
    
    private func configureKeyboardManager() {
        let keyboardManager = IQKeyboardManager.shared
        keyboardManager.enable = true
        keyboardManager.enableAutoToolbar = true
        keyboardManager.shouldResignOnTouchOutside = true
        keyboardManager.keyboardDistanceFromTextField = 88
        keyboardManager.toolbarDoneBarButtonItemText = "Скрыть"
    }
}
