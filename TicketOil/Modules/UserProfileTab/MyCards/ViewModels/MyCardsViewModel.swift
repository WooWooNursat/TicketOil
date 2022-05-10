//
//  MyCardsViewModel.swift
//  TicketOil
//
//  Created by Nursat on 10.05.2022.
//

import Foundation

protocol MyCardsViewModelProtocol: ViewModel {
    
}

final class MyCardsViewModel: MyCardsViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Methods
}

