//
//  MakePaymentViewModel.swift
//  TicketOil
//
//  Created by Nursat on 09.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol MakePaymentViewModelProtocol: ViewModel {
    var product: BehaviorRelay<Product> { get }
    var preferredCard: BehaviorRelay<Card?> { get }
    
    func openPaymentSuccess()
    func chooseCard()
}

final class MakePaymentViewModel: MakePaymentViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    private let cardsRepository: CardsRepository
    var product: BehaviorRelay<Product>
    var preferredCard: BehaviorRelay<Card?>
    
    // MARK: - Lifecycle
    
    init(router: Router, product: Product, cardsRepository: CardsRepository) {
        self.router = router
        self.cardsRepository = cardsRepository
        self.product = .init(value: product)
        preferredCard = .init(value: cardsRepository.preferredCard)
    }
    
    // MARK: - Methods
    
    func openPaymentSuccess() {
        let context = MakePaymentRouter.RouteType.paymentSuccess
        router.enqueueRoute(with: context)
    }
    
    func chooseCard() {
        let context = MakePaymentRouter.RouteType.chooseCard { [weak self] card in
            guard let self = self else { return }
            
            self.preferredCard.accept(card)
            self.cardsRepository.preferredCard = card
        }
        router.enqueueRoute(with: context)
    }
}

