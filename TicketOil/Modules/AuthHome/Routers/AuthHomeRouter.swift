//
//  AuthHome.swift
//  TicketOil
//
//  Created by Nursat on 17.04.2022.
//

import UIKit

final class AuthHomeRouter: Router {
    // MARK: - Enums
    
    enum PresentationContext {
        case `default`
    }
    
    enum RouteType {
        case register
        case mainTabBar
    }
    
    // MARK: - Properties
    
    weak var baseViewController: UIViewController?
    
    // MARK: - Methods
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion _: (() -> Void)?) {
        guard let context = context as? PresentationContext else {
            assertionFailure("The context type mismatch")
            return
        }
        
        baseViewController = baseVC
        
        switch context {
        case .default:
            return
        }
    }
    
    func setRootViewController() {
        let vc = AuthHomeViewController(navigationBarConfigurator: DIResolver.resolve(NavigationBarConfigurator.self)!)
        vc.viewModel = AuthHomeViewModel(router: self)
        
        let navVC = UINavigationController(rootViewController: vc)
        baseViewController = vc
        navVC.setRootViewController()
    }
    
    func enqueueRoute(with context: Any?, animated _: Bool, completion _: (() -> Void)?) {
        guard let routeType = context as? RouteType else {
            assertionFailure("The route type mismatch")
            return
        }
        
        guard let baseVC = baseViewController else {
            assertionFailure("baseViewController is not set")
            return
        }
        
        switch routeType {
        case .register:
            let router = UserRegisterRouter()
            let context = UserRegisterRouter.PresentationContext.default
            router.present(on: baseVC, animated: true, context: context, completion: nil)
        case .mainTabBar:
            MainTabBarController().setRootViewController()
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        baseViewController?.dismiss(animated: animated, completion: completion)
    }
}
