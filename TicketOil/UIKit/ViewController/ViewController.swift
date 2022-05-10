//
//  ViewController.swift
//  TicketOil
//
//  Created by Nursat on 10.05.2022.
//

import Foundation
import UIKit

public class ViewController: UIViewController {
    // MARK: - Lifecycle
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationCapturesStatusBarAppearance = true
    }
    
    internal var topInset: CGFloat {
        let navBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        return navBarHeight + statusBarHeight
    }
    
    internal var bottomInset: CGFloat {
        let tabbarHeight = tabBarController?.tabBar.frame.height ?? 0
        
        return tabbarHeight
    }
}
