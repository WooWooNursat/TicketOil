//
//  Router.swift
//  TicketOil
//
//  Created by Nursat on 19.04.2022.
//

import UIKit

public protocol Router: AnyObject {
    var baseViewController: UIViewController? { get set }
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: (() -> Void)?)
    func enqueueRoute(with context: Any?, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension Router {
    func present(on baseVC: UIViewController, context: Any?) {
        present(on: baseVC, animated: true, context: context, completion: nil)
    }
    
    func enqueueRoute(with context: Any?) {
        enqueueRoute(with: context, animated: true, completion: nil)
    }
    
    func enqueueRoute(with context: Any?, completion: (() -> Void)?) {
        enqueueRoute(with: context, animated: true, completion: completion)
    }
    
    func dismiss(animated: Bool = true) {
        dismiss(animated: animated, completion: nil)
    }
}
