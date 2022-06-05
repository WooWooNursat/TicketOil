//
//  GasStationSearchViewModel.swift
//  TicketOil
//
//  Created by Nursat on 05.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol GasStationSearchViewModelProtocol: ViewModel {
    var cellViewModels: [GasStationSearchTableCellViewModelProtocol] { get }
    var update: BehaviorRelay<Void> { get }
}

final class GasStationSearchViewModel: GasStationSearchViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var cellViewModels: [GasStationSearchTableCellViewModelProtocol]
    var update: BehaviorRelay<Void>
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
        cellViewModels = []
        update = .init(value: ())
    }
    
    // MARK: - Methods
}

