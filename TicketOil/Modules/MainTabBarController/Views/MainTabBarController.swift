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
        vc.viewModel = AllGasStationsViewModel(router: router, gasStationsRepository: DIResolver.resolve(GasStationsRepository.self)!)
        
        let item = UITabBarItem(title: "Главная", image: Assets.homeTab.image, selectedImage: nil)
        item.imageInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        vc.tabBarItem = item
        return vc
    }()
    
    lazy var searchVC: SearchMapViewController = {
        let vc = SearchMapViewController(navigationBarConfigurator: DIResolver.resolve(NavigationBarConfigurator.self)!)
        let router = SearchMapRouter()
        router.baseViewController = vc
        vc.viewModel = SearchMapViewModel(router: router, gasStationsRepository: DIResolver.resolve(GasStationsRepository.self)!)
        
        let item = UITabBarItem(title: "Поиск", image: Assets.searchTab.image, selectedImage: nil)
        item.imageInsets = .init(top: 7, left: 7, bottom: 7, right: 7)
        vc.tabBarItem = item
        return vc
    }()
    
    lazy var qrScanVC: QRScanViewController = {
        let vc = QRScanViewController(navigationBarConfigurator: DIResolver.resolve(NavigationBarConfigurator.self)!)
        let router = QRScanRouter()
        router.baseViewController = vc
        vc.viewModel = QRScanViewModel(router: router, gasStationsRepository: DIResolver.resolve(GasStationsRepository.self)!)
        
        let item = UITabBarItem(title: "Скан", image: Assets.scanTab.image, selectedImage: nil)
        item.imageInsets = .init(top: 6, left: 6, bottom: 6, right: 6)
        vc.tabBarItem = item
        
        return vc
    }()
    
    lazy var userProfileVC: UserProfileMenuViewController = {
        let vc = UserProfileMenuViewController(navigationBarConfiguration: DIResolver.resolve(NavigationBarConfigurator.self)!)
        let router = UserProfileMenuRouter()
        router.baseViewController = vc
        vc.viewModel = UserProfileMenuViewModel(router: router)
        
        let item = UITabBarItem(title: "Профиль", image: Assets.profileTab.image, selectedImage: nil)
        item.imageInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
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
