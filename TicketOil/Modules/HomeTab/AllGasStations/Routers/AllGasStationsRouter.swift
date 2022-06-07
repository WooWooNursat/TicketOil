//
//  AllGasStationsRouter.swift
//  TicketOil
//
//  Created by Nursat on 07.06.2022.
//

import Foundation
import UIKit

final class AllGasStationsRouter: Router {
    // MARK: - Enums
    
    enum PresentationContext {
        case `default`
    }
    
    enum RouteType {
        case gasolineSelect(GasStation)
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
            break
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
        case let .gasolineSelect(gasStation):
            let router = GasolineSelectRouter()
            let context = GasolineSelectRouter.PresentationContext.default(gasStation: gasStation)
            router.present(on: baseVC, animated: animated, context: context, completion: completion)
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        baseViewController?.dismiss(animated: animated, completion: completion)
    }
}
