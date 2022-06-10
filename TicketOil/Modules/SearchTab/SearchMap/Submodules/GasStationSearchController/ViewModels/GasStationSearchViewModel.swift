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
    var searchText: String { get set }
    
    func openGasolineSelect(index: Int)
}

final class GasStationSearchViewModel: GasStationSearchViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    private let gasStationsRepository: GasStationsRepository
    var cellViewModels: [GasStationSearchTableCellViewModelProtocol]
    var update: BehaviorRelay<Void>
    var searchText: String = "" {
        didSet {
            guard oldValue != searchText else { return }
            
            guard !searchText.isEmpty else {
                cellViewModels = []
                update.accept(())
                return
            }
            
            let gasStations = gasStationsRepository.gasStations.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
            cellViewModels = gasStations.map {
                GasStationSearchTableCellViewModel(router: router, gasStation: $0)
            }
            update.accept(())
        }
    }
    
    // MARK: - Lifecycle
    
    init(router: Router, gasStationsRepository: GasStationsRepository) {
        self.router = router
        self.gasStationsRepository = gasStationsRepository
        cellViewModels = []
        update = .init(value: ())
    }
    
    // MARK: - Methods
    
    func openGasolineSelect(index: Int) {
        let gasStation = cellViewModels[index].gasStation.value
        let context = SearchMapRouter.RouteType.gasolineSelect(gasStation: gasStation)
        router.enqueueRoute(with: context)
    }
}

