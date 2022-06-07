//
//  GasolineSelectViewModel.swift
//  TicketOil
//
//  Created by Nursat on 28.05.2022.
//

import Foundation

protocol GasolineSelectViewModelProtocol: ViewModel {
    
}

final class GasolineSelectViewModel: GasolineSelectViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    private let gasStation: GasStation
    
    // MARK: - Lifecycle
    
    init(router: Router, gasStation: GasStation) {
        self.router = router
        self.gasStation = gasStation
    }
    
    // MARK: - Methods
}

