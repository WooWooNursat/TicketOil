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
}

final class SearchMapViewModel: SearchMapViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var isAnimating: BehaviorRelay<Bool>
    var gasStations: BehaviorRelay<[GasStation]>
    var searchViewModel: GasStationSearchViewModel
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
        isAnimating = .init(value: false)
        gasStations = .init(value: [])
        searchViewModel = GasStationSearchViewModel(router: router)
    }
    
    // MARK: - Methods
}

