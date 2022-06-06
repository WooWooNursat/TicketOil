//
//  MainTabBarController.swift
//  TicketOil
//
//  Created by Nursat on 21.04.2022.
//

import Foundation
import UIKit
import SnapKit

final class MainTabBarController: UITabBarController {
    // MARK: - Variables
    
    // MARK: - Outlets
    
    lazy var homeVC: AllGasStationsViewController = {
        let vc = AllGasStationsViewController(navigationBarConfigurator: DIResolver.resolve(NavigationBarConfigurator.self)!)
        let router = AllGasStationsRouter()
        router.baseViewController = vc
        vc.viewModel = AllGasStationsViewModel(router: router)
        
        let item = UITabBarItem(title: "Главная", image: UIImage(), selectedImage: nil)
        vc.tabBarItem = item
        return vc
    }()
    
    lazy var searchVC: SearchMapViewController = {
        let vc = SearchMapViewController(navigationBarConfigurator: DIResolver.resolve(NavigationBarConfigurator.self)!)
        let router = SearchMapRouter()
        router.baseViewController = vc
        vc.viewModel = SearchMapViewModel(router: router)
        
        let item = UITabBarItem(title: "Поиск", image: UIImage(), selectedImage: nil)
        vc.tabBarItem = item
        return vc
    }()
    
    lazy var qrScanVC: QRScanViewController = {
        let vc = QRScanViewController(navigationBarConfigurator: DIResolver.resolve(NavigationBarConfigurator.self)!)
        let router = QRScanRouter()
        router.baseViewController = vc
        vc.viewModel = QRScanViewModel(router: router)
        
        let item = UITabBarItem(title: "Скан", image: UIImage(), selectedImage: nil)
        vc.tabBarItem = item
        
        return vc
    }()
    
    lazy var userProfileVC: UserProfileMenuViewController = {
        let vc = UserProfileMenuViewController(navigationBarConfiguration: DIResolver.resolve(NavigationBarConfigurator.self)!)
        let router = UserProfileMenuRouter()
        router.baseViewController = vc
        vc.viewModel = UserProfileMenuViewModel(router: router)
        
        let item = UITabBarItem(title: "Профиль", image: UIImage(), selectedImage: nil)
        vc.tabBarItem = item
        
        return vc
    }()
    
    // MARK: - Actions
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBar.itemPositioning = .fill
        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: searchVC),
            UINavigationController(rootViewController: qrScanVC),
            UINavigationController(rootViewController: userProfileVC)
        ]
    }
    
    required init?(coder _: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        markup()
        subscribe()
    }
    
    // MARK: - Configurations
    
    private func subscribe() {
        
    }
    
    // MARK: - Markup
    
    private func markup() {
        tabBar.tintColor = UIColor(hex: "#D61616")
    }
}
