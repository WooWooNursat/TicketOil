//
//  UserProfileEditRouter.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation
import UIKit

final class UserProfileEditRouter: Router {
    // MARK: - Enums
    
    enum PresentationContext {
        case `default`
        case registration
    }
    
    enum RouteType {
    }
    
    // MARK: - Properties
    
    var context: PresentationContext?
    weak var baseViewController: UIViewController?
    
    // MARK: - Methods
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion _: (() -> Void)?) {
        guard let context = context as? PresentationContext else {
            assertionFailure("The context type mismatch")
            return
        }
        
        baseViewController = baseVC
        self.context = context
        
        switch context {
        default:
            let vc = UserProfileEditViewController(navigationBarConfigurator: DIResolver.resolve(NavigationBarConfigurator.self)!)
            vc.viewModel = UserProfileEditViewModel(router: self, userManager: DIResolver.resolve(UserManager.self)!)
            baseVC.navigationController?.pushViewController(vc, animated: animated)
        }
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
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        guard let context = context else {
            return
        }

        switch context {
        case .default:
            baseViewController?.navigationController?.popViewController(animated: animated)
        case .registration:
            MainTabBarController().setRootViewController()
        }
    }
}
