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
    
}

final class MyCardTableCellViewModel: MyCardTableCellViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Methods
}

