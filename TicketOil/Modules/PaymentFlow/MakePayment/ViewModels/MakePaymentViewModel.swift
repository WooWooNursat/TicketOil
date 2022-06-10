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
    
    func openPaymentSuccess()
}

final class MakePaymentViewModel: MakePaymentViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var product: BehaviorRelay<Product>
    
    // MARK: - Lifecycle
    
    init(router: Router, product: Product) {
        self.router = router
        self.product = .init(value: product)
    }
    
    // MARK: - Methods
    
    func openPaymentSuccess() {
        let context = MakePaymentRouter.RouteType.paymentSuccess
        router.enqueueRoute(with: context)
    }
}

