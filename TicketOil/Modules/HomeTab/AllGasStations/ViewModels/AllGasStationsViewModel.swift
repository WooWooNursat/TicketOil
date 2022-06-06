//
//  AllGasStationsViewModel.swift
//  TicketOil
//
//  Created by Nursat on 07.06.2022.
//

import Foundation
import RxRelay

protocol AllGasStationsViewModelProtocol: ViewModel {
    var update: BehaviorRelay<Void> { get }
    var cellViewModels: [GasStationListItemTableCellViewModelProtocol] { get }
}

final class AllGasStationsViewModel: AllGasStationsViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var update: BehaviorRelay<Void>
    var cellViewModels: [GasStationListItemTableCellViewModelProtocol]
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
        update = .init(value: ())
        cellViewModels = []
    }
    
    // MARK: - Methods
}

