//
//  MyCardsViewModel.swift
//  TicketOil
//
//  Created by Nursat on 10.05.2022.
//

import Foundation

protocol MyCardsViewModelProtocol: ViewModel {
    func addCard()
}

final class MyCardsViewModel: MyCardsViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Methods
    
    func addCard() {
        let context = MyCardsRouter.RouteType.addCard
        router.enqueueRoute(with: context)
    }
}

