//
//  GasolineSelectViewModel.swift
//  TicketOil
//
//  Created by Nursat on 28.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol GasolineSelectViewModelProtocol: ViewModel {
    var gasStation: BehaviorRelay<GasStation> { get }
    var isContinueButtonEnabled: BehaviorRelay<Bool> { get }
    var columnNumbers: [String] { get }
    var gasolineTypes: [String] { get }
    
    func setSelectedColumnNumber(index: Int)
    func setSelectedGasolineType(index: Int)
    func setLitresNumber(_ number: Int)
    func setChosenFullTank(_ isChosenFullTank: Bool)
    func makePayment()
}

final class GasolineSelectViewModel: GasolineSelectViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var gasStation: BehaviorRelay<GasStation>
    var isContinueButtonEnabled: BehaviorRelay<Bool>
    var columnNumbers: [String]
    var gasolineTypes: [String]
    private var selectedColumnNumber: Int?
    private var selectedGasolineType: String?
    private var litresNumber: Int = 1
    private var isChosenFullTank: Bool = false
    private var _columnNumbers: [Int]
    
    // MARK: - Lifecycle
    
    init(router: Router, gasStation: GasStation) {
        self.router = router
        self.gasStation = .init(value: gasStation)
        self.isContinueButtonEnabled = .init(value: false)
        _columnNumbers = [1, 2, 3, 4]
        columnNumbers = _columnNumbers.map { "Колонка \($0)" }
        gasolineTypes = ["Дизельное топливо", "АИ-92", "АИ-95", "АИ-98"]
        updateContinueButton()
    }
    
    // MARK: - Methods
    
    func setSelectedColumnNumber(index: Int) {
        selectedColumnNumber = _columnNumbers[index]
        updateContinueButton()
    }
    
    func setSelectedGasolineType(index: Int) {
        selectedGasolineType = gasolineTypes[index]
        updateContinueButton()
    }
    
    func setLitresNumber(_ number: Int) {
        litresNumber = number
    }
    
    func setChosenFullTank(_ isChosenFullTank: Bool) {
        self.isChosenFullTank = isChosenFullTank
    }
    
    func makePayment()  {
        guard let selectedColumnNumber = selectedColumnNumber,
              let selectedGasolineType = selectedGasolineType
        else {
            return
        }

        let product = Product(
            gasStation: gasStation.value,
            columnNumber: selectedColumnNumber,
            gasolineType: selectedGasolineType,
            litresNumber: litresNumber,
            isFullTank: isChosenFullTank
        )
        let context = GasolineSelectRouter.RouteType.makePayment(product: product)
        router.enqueueRoute(with: context)
    }
    
    private func updateContinueButton() {
        isContinueButtonEnabled.accept(selectedColumnNumber != nil && selectedGasolineType != nil)
    }
}

