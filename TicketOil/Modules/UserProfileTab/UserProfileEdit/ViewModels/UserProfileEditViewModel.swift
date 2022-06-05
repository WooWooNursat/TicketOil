//
//  UserProfileEditViewModel.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation

protocol UserProfileEditViewModelProtocol: ViewModel {
    var cellViewModels: [UserProfileEditTableCellViewModelProtocol] { get }
}

final class UserProfileEditViewModel: UserProfileEditViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var cellViewModels: [UserProfileEditTableCellViewModelProtocol]
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
        cellViewModels = UserProfileDataRow.allCases.map {
            UserProfileEditTableCellViewModel(router: router, row: $0)
        }
    }
    
    // MARK: - Methods
}

