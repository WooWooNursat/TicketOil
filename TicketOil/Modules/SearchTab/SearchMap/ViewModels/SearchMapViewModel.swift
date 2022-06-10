//
//  SearchMapViewModel.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchMapViewModelProtocol: ViewModel {
    var isAnimating: BehaviorRelay<Bool> { get }
    var gasStations: BehaviorRelay<[GasStation]> { get }
    var searchViewModel: GasStationSearchViewModel { get }
    
    func openGasolineSelect(gasStation: GasStation)
}

final class SearchMapViewModel: SearchMapViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    private let gasStationsRepository: GasStationsRepository
    var isAnimating: BehaviorRelay<Bool>
    var gasStations: BehaviorRelay<[GasStation]>
    var searchViewModel: GasStationSearchViewModel
    
    // MARK: - Lifecycle
    
    init(router: Router, gasStationsRepository: GasStationsRepository) {
        self.router = router
        self.gasStationsRepository = gasStationsRepository
        isAnimating = .init(value: false)
        gasStations = .init(value: gasStationsRepository.gasStations)
        searchViewModel = GasStationSearchViewModel(router: router, gasStationsRepository: gasStationsRepository)
    }
    
    // MARK: - Methods
    
    func openGasolineSelect(gasStation: GasStation) {
        let context = SearchMapRouter.RouteType.gasolineSelect(gasStation: gasStation)
        router.enqueueRoute(with: context)
    }
}

