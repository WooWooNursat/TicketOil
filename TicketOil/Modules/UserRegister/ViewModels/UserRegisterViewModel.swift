//
//  UserRegisterViewModel.swift
//  TicketOil
//
//  Created by Nursat on 20.04.2022.
//

import Foundation

protocol UserRegisterViewModelProtocol: ViewModel {
    
}

final class UserRegisterViewModel: UserRegisterViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Methods
}

