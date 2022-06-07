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
    var update: BehaviorRelay<Void>
    var cellViewModels: [GasStationListItemTableCellViewModelProtocol]
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
        update = .init(value: ())
        cellViewModels = [
            GasStationListItemTableCellViewModel(router: router, gasStation: GasStation(id: 0, image: URL(string: "www.google.com")!, name: "V-Oil #1", location: Location(address: "asgerg 32", latitude: 45, longitude: 46)))
        ]
    }
    
    // MARK: - Methods
    
    func chooseGasStation(index: Int) {
        let gasStation = cellViewModels[index].gasStation.value
        let context = AllGasStationsRouter.RouteType.gasolineSelect(gasStation)
        router.enqueueRoute(with: context)
    }
}

