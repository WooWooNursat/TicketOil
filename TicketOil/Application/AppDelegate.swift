//
//  AppDelegate.swift
//  TicketOil
//
//  Created by Nursat on 17.04.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .black
        
        window?.rootViewController = LaunchScreenViewController()
        
        return true
    }
}

