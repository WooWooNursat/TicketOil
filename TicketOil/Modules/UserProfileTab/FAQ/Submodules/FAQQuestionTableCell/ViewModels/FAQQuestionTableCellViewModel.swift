//
//  FAQQuestionTableCellViewModel.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol FAQQuestionTableCellViewModelProtocol: ViewModel {
    var question: BehaviorRelay<String> { get }
    var isOpen: BehaviorRelay<Bool> { get }
}

final class FAQQuestionTableCellViewModel: FAQQuestionTableCellViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var question: BehaviorRelay<String>
    var isOpen: BehaviorRelay<Bool>
    
    // MARK: - Lifecycle
    
    init(router: Router, question: String) {
        self.router = router
        self.question = .init(value: question)
        isOpen = .init(value: false)
    }
    
    // MARK: - Methods
}

