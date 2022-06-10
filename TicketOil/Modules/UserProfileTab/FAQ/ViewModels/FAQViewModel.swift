//
//  FAQViewModel.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation

protocol FAQViewModelProtocol: ViewModel {
    var faqViewModels: [[ViewModel]] { get }
}

final class FAQViewModel: FAQViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var faqViewModels: [[ViewModel]]
    let faqs = [
        FAQ(question: "Что такое Ticketoil?", answer: "Это приложение, которое позволит вам оплачивать услуги на автозаправочных станциях онлайн, не выходя из машины."),
        FAQ(question: "Как происходит оплата?", answer: "Вы привязываете свою банковскую карту, после чего с неё будут списываться денежные средства на оплату услуг."),
        FAQ(question: "Что делать если я нашёл баг?", answer: "Обратитесь с ним в службу поддержки.")
    ]
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
        faqViewModels = faqs.map { faq in
            [
                FAQQuestionTableCellViewModel(router: router, question: faq.question),
                FAQAnswerTableCellViewModel(router: router, answer: faq.answer)
            ]
        }
    }
    
    // MARK: - Methods
}

