//
//  ColumnSelectViewModel.swift
//  TicketOil
//
//  Created by Nursat on 28.05.2022.
//

import Foundation

protocol ColumnSelectViewModelProtocol: ViewModel {
    
}

final class ColumnSelectViewModel: ColumnSelectViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Methods
}

