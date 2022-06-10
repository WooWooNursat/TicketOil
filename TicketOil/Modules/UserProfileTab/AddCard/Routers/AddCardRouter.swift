//
//  AddCardRouter.swift
//  TicketOil
//
//  Created by Nursat on 11.05.2022.
//

import Foundation
import UIKit

final class AddCardRouter: Router {
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
            let vc = AddCardViewController(navigationBarConfigurator: DIResolver.resolve(NavigationBarConfigurator.self)!)
            vc.viewModel = AddCardViewModel(router: self, cardsRepository: DIResolver.resolve(CardsRepository.self)!)
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
        baseViewController?.navigationController?.popViewController(animated: animated)
    }
}
