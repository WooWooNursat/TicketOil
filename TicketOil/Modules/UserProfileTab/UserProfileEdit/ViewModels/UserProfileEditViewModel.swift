//
//  UserProfileEditViewModel.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserProfileEditViewModelProtocol: ViewModel {
    var cellViewModels: [UserProfileEditTableCellViewModelProtocol] { get }
    var name: String { get set }
    var surname: String { get set }
    var carNumber: String { get set }
    var gasolineType: String? { get set }
    var isEnabledSaveButton: BehaviorRelay<Bool> { get }
    
    func save()
}

final class UserProfileEditViewModel: UserProfileEditViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    private let userManager: UserManager
    var cellViewModels: [UserProfileEditTableCellViewModelProtocol]
    var name: String
    var surname: String
    var carNumber: String
    var gasolineType: String?
    var isEnabledSaveButton: BehaviorRelay<Bool>
    
    // MARK: - Lifecycle
    
    init(router: Router, userManager: UserManager) {
        self.router = router
        self.userManager = userManager
        name = userManager.user?.name ?? ""
        surname = userManager.user?.surname ?? ""
        carNumber = userManager.user?.carNumber ?? ""
        cellViewModels = UserProfileDataRow.allCases.map {
            UserProfileEditTableCellViewModel(router: router, row: $0)
        }
        isEnabledSaveButton = .init(value: !name.isEmpty && !surname.isEmpty && !carNumber.isEmpty)
    }
    
    // MARK: - Methods
    
    func save() {
        guard var user = userManager.user else {
            return
        }
        
        user.name = name
        user.surname = surname
        user.carNumber = carNumber
        user.gasolineType = gasolineType
        userManager.user = user
        router.dismiss()
    }
}

