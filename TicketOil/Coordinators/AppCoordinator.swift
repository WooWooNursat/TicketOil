//
//  AppCoordinator.swift
//  TicketOil
//
//  Created by Nursat on 08.05.2022.
//

import Foundation
import UIKit

final class AppCoordinator {
    func start() {
        presentLaunchScreen()
        presentAuthHome()
    }
    
    private func presentLaunchScreen() {
        LaunchScreenViewController().setRootViewController()
    }
    
    private func presentAuthHome() {
        let router = AuthHomeRouter()
        router.setRootViewController()
    }
}
