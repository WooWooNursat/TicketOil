//
//  QRScanViewModel.swift
//  TicketOil
//
//  Created by Nursat on 09.05.2022.
//

import Foundation

protocol QRScanViewModelProtocol: ViewModel {
    
}

final class QRScanViewModel: QRScanViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Methods
}

