//
//  FAQAnswerTableCellViewModel.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol FAQAnswerTableCellViewModelProtocol: ViewModel {
    var answer: BehaviorRelay<String> { get }
}

final class FAQAnswerTableCellViewModel: FAQAnswerTableCellViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var answer: BehaviorRelay<String>
    
    // MARK: - Lifecycle
    
    init(router: Router, answer: String) {
        self.router = router
        self.answer = .init(value: answer)
    }
    
    // MARK: - Methods
}

