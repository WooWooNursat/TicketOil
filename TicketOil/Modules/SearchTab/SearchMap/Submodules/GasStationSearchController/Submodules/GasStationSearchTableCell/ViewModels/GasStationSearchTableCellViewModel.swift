//
//  GasStationSearchTableCellViewModel.swift
//  TicketOil
//
//  Created by Nursat on 05.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol GasStationSearchTableCellViewModelProtocol: ViewModel {
    var gasStation: BehaviorRelay<GasStation> { get }
}

final class GasStationSearchTableCellViewModel: GasStationSearchTableCellViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var gasStation: BehaviorRelay<GasStation>
    
    // MARK: - Lifecycle
    
    init(router: Router, gasStation: GasStation) {
        self.router = router
        self.gasStation = .init(value: gasStation)
    }
    
    // MARK: - Methods
}

