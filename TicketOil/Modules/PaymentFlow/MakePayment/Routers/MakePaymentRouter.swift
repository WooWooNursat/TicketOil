//
//  MakePaymentRouter.swift
//  TicketOil
//
//  Created by Nursat on 09.06.2022.
//

import Foundation
import UIKit

final class MakePaymentRouter: Router {
    // MARK: - Enums
    
    enum PresentationContext {
        case `default`(product: Product)
    }
    
    enum RouteType {
        case paymentSuccess
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
        case let .default(product):
            let vc = MakePaymentViewController(navigationBarConfigurator: DIResolver.resolve(NavigationBarConfigurator.self)!)
            vc.viewModel = MakePaymentViewModel(router: self, product: product)
            baseVC.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: (() -> Void)?) {
        guard let routeType = context as? RouteType else {
            assertionFailure("The route type mismatch")
            return
        }
        
        guard let baseVC = baseViewController else {
            assertionFailure("baseViewController is not set")
            return
        }
        
        switch routeType {
        case .paymentSuccess:
            let router = PaymentSucessRouter()
            let context = PaymentSucessRouter.PresentationContext.default
            router.present(on: baseVC, animated: animated, context: context, completion: completion)
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        baseViewController?.dismiss(animated: animated, completion: completion)
    }
}
