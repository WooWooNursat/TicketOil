//
//  QRScanViewModel.swift
//  TicketOil
//
//  Created by Nursat on 09.05.2022.
//

import Foundation

protocol QRScanViewModelProtocol: ViewModel {
    func handleQrCode(_ qrCode: String)
}

final class QRScanViewModel: QRScanViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    private let gasStationsRepository: GasStationsRepository
    
    // MARK: - Lifecycle
    
    init(router: Router, gasStationsRepository: GasStationsRepository) {
        self.router = router
        self.gasStationsRepository = gasStationsRepository
    }
    
    // MARK: - Methods
    
    func handleQrCode(_ qrCode: String) {
        let values = qrCode.split(separator: "#")
        guard let gasStationId = values.first,
              let columnNumberString = values.last,
              let gasStation = gasStationsRepository.gasStations.first(where: { $0.id == Int(gasStationId) }),
              let columnNumber = Int(columnNumberString)
        else { return }
        let context = QRScanRouter.RouteType.gasolineSelect(gasStation: gasStation, columnNumber: columnNumber)
        router.enqueueRoute(with: context)
    }
}

