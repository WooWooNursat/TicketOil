//
//  GasStationListItemTableCellViewModel.swift
//  TicketOil
//
//  Created by Nursat on 07.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol GasStationListItemTableCellViewModelProtocol: ViewModel {
    var gasStation: BehaviorRelay<GasStation> { get }
}

final class GasStationListItemTableCellViewModel: GasStationListItemTableCellViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var gasStation: BehaviorRelay<GasStation>
    
    // MARK: - Lifecycle
    
    init(router: Router, gasStation: GasStation) {
        self.router = router
        gasStation = .init(from: gasStation)
    }
    
    // MARK: - Methods
}

