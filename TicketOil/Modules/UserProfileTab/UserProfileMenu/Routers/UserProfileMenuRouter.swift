//
//  UserProfileMenuRouter.swift
//  TicketOil
//
//  Created by Nursat on 22.04.2022.
//

import Foundation
import UIKit

final class UserProfileMenuRouter: Router {
    // MARK: - Enums
    
    enum PresentationContext {
        case `default`
    }
    
    enum RouteType {
        case myCards
        case userProfileEdit
        case inviteFriend
        case faq
        case logout
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
        case .myCards:
            let router = MyCardsRouter()
            let context = MyCardsRouter.PresentationContext.myCards()
            router.present(on: baseVC, animated: animated, context: context, completion: completion)
        case .userProfileEdit:
            let router = UserProfileEditRouter()
            let context = UserProfileEditRouter.PresentationContext.default
            router.present(on: baseVC, animated: animated, context: context, completion: completion)
        case .inviteFriend:
            let inviteString = "Скачивай приложение TicketOil и оплачивай за бензин не выходя из машины! [Ссылка на скачивание приложения]"
            let vc = UIActivityViewController(activityItems: [inviteString], applicationActivities: nil)
            baseVC.present(vc, animated: animated, completion: completion)
        case .faq:
            let router = FAQRouter()
            let context = FAQRouter.PresentationContext.default
            router.present(on: baseVC, animated: animated, context: context, completion: completion)
        case .logout:
            let alert = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            alert.addAction(UIAlertAction(title: "Выйти", style: .destructive) { _ in
                AuthHomeRouter().setRootViewController()
            })
            baseVC.present(alert, animated: animated, completion: completion)
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        baseViewController?.dismiss(animated: animated, completion: completion)
    }
}
