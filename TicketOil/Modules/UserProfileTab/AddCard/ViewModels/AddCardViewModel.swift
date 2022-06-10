//
//  AddCardViewModel.swift
//  TicketOil
//
//  Created by Nursat on 11.05.2022.
//

import Foundation

protocol AddCardViewModelProtocol: ViewModel {
    func addCard(number: String, name: String, expirationMonth: String, expirationYear: String, cvv: String)
}

final class AddCardViewModel: AddCardViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    private let cardsRepository: CardsRepository
    
    // MARK: - Lifecycle
    
    init(router: Router, cardsRepository: CardsRepository) {
        self.router = router
        self.cardsRepository = cardsRepository
    }
    
    // MARK: - Methods
    
    func addCard(number: String, name: String, expirationMonth: String, expirationYear: String, cvv: String) {
        guard let year = Int(expirationYear),
              let month = Int(expirationMonth),
              let date = Date(year: year, month: month)
        else { return }
        
        let card = Card(number: number, cardHolderName: name, expirationDate: date, cvv: cvv)
        cardsRepository.cards.append(card)
        router.dismiss(animated: true)
    }
}

