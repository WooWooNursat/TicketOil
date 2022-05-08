//
//  UserProfileMenuViewModel.swift
//  TicketOil
//
//  Created by Nursat on 22.04.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserProfileMenuViewModelProtocol: ViewModel {
    var cellViewModels: [[UserProfileMenuTableCellViewModelProtocol]] { get }
    var update: BehaviorRelay<Void> { get }
}

final class UserProfileMenuViewModel: UserProfileMenuViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var cellViewModels: [[UserProfileMenuTableCellViewModelProtocol]]
    var update: BehaviorRelay<Void>
    let rowTypes: [[UserProfileMenuRowType]] = [
        [.myCards, .inviteFriend, .transactionsHistory, .contactUs],
        [.logOut]
    ]
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
        cellViewModels = rowTypes.map { section in
            section.map { UserProfileMenuTableCellViewModel(router: router, type: $0) }
        }
        update = .init(value: ())
    }
    
    // MARK: - Methods
}

