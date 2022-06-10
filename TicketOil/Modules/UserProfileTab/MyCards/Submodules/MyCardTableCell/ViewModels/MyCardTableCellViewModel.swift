//
//  MyCardTableCellViewModel.swift
//  TicketOil
//
//  Created by Nursat on 12.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol MyCardTableCellViewModelProtocol: ViewModel {
    var card: BehaviorRelay<Card> { get }
}

final class MyCardTableCellViewModel: MyCardTableCellViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var card: BehaviorRelay<Card>
    
    // MARK: - Lifecycle
    
    init(router: Router, card: Card) {
        self.router = router
        self.card = .init(value: card)
    }
    
    // MARK: - Methods
}

