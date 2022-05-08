//
//  AuthHomeViewModel.swift
//  TicketOil
//
//  Created by Nursat on 17.04.2022.
//


protocol AuthHomeViewModelProtocol: ViewModel {
    
}

final class AuthHomeViewModel: AuthHomeViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Methods
}

