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
    
    func chooseGasStation(index: Int)
}

final class AllGasStationsViewModel: AllGasStationsViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    private let gasStationsRepository: GasStationsRepository
    var update: BehaviorRelay<Void>
    var cellViewModels: [GasStationListItemTableCellViewModelProtocol]
    
    // MARK: - Lifecycle
    
    init(router: Router, gasStationsRepository: GasStationsRepository) {
        self.router = router
        self.gasStationsRepository = gasStationsRepository
        update = .init(value: ())
        cellViewModels = gasStationsRepository.gasStations.map {
            GasStationListItemTableCellViewModel(router: router, gasStation: $0)
        }
    }
    
    // MARK: - Methods
    
    func chooseGasStation(index: Int) {
        let gasStation = cellViewModels[index].gasStation.value
        let context = AllGasStationsRouter.RouteType.gasolineSelect(gasStation)
        router.enqueueRoute(with: context)
    }
}

