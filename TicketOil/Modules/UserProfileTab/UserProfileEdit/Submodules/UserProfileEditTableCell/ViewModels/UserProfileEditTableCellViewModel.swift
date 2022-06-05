//
//  UserProfileEditTableCellViewModel.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserProfileEditTableCellViewModelProtocol: ViewModel {
    var row: BehaviorRelay<UserProfileDataRow> { get }
}

final class UserProfileEditTableCellViewModel: UserProfileEditTableCellViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var row: BehaviorRelay<UserProfileDataRow>
    
    // MARK: - Lifecycle
    
    init(router: Router, row: UserProfileDataRow) {
        self.router = router
        self.row = .init(value: row)
    }
    
    // MARK: - Methods
}

