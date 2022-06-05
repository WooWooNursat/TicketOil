//
//  PaymentSuccessViewModel.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation

protocol PaymentSuccessViewModelProtocol: ViewModel {
    
}

final class PaymentSuccessViewModel: PaymentSuccessViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Methods
}

