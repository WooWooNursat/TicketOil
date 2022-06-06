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
    }
    
    enum RouteType {
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
            let vc = UserProfileEditViewController(navigationBarConfigurator: DIResolver.resolve(NavigationBarConfigurator.self)!)
            vc.viewModel = UserProfileEditViewModel(router: self)
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
        baseViewController?.dismiss(animated: animated, completion: completion)
    }
}
