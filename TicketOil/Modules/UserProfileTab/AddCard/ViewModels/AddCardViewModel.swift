//
//  AddCardViewModel.swift
//  TicketOil
//
//  Created by Nursat on 11.05.2022.
//

import Foundation

protocol AddCardViewModelProtocol: ViewModel {
    func addCard()
}

final class AddCardViewModel: AddCardViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Methods
    
    func addCard() {
        router.dismiss(animated: true)
    }
}

