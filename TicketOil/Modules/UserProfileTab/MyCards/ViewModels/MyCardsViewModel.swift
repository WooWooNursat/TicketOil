//
//  MyCardsViewModel.swift
//  TicketOil
//
//  Created by Nursat on 10.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol MyCardsViewModelProtocol: ViewModel {
    var cellViewModels: [MyCardTableCellViewModelProtocol] { get }
    var update: BehaviorRelay<Void> { get }
    
    func addCard()
    func selectCard(index: Int)
    func updateCards()
    func deleteCard(index: Int)
}

final class MyCardsViewModel: MyCardsViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    private let cardsRepository: CardsRepository
    var cellViewModels: [MyCardTableCellViewModelProtocol]
    var update: BehaviorRelay<Void>
    private var callBack: ((Card) -> Void)?
    
    // MARK: - Lifecycle
    
    init(router: Router, cardsRepository: CardsRepository, callBack: ((Card) -> Void)?) {
        self.router = router
        self.cardsRepository = cardsRepository
        self.callBack = callBack
        self.update = .init(value: ())
        cellViewModels = []
    }
    
    // MARK: - Methods
    
    func addCard() {
        let context = MyCardsRouter.RouteType.addCard
        router.enqueueRoute(with: context)
    }
    
    func selectCard(index: Int) {
        guard let callBack = callBack else {
            return
        }

        callBack(cellViewModels[index].card.value)
        router.dismiss()
    }
    
    func updateCards() {
        cellViewModels = cardsRepository.cards.map { card in
            MyCardTableCellViewModel(router: router, card: card)
        }
        update.accept(())
    }
    
    func deleteCard(index: Int) {
        let cards = cardsRepository.cards
        let filteredCards = cards.filter { $0 != cards[index] }
        cardsRepository.cards = filteredCards
        cellViewModels.remove(at: index)
    }
}

