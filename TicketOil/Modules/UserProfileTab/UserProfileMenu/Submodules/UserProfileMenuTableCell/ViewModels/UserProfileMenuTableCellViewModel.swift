//
//  UserProfileMenuTableCellViewModel.swift
//  TicketOil
//
//  Created by Nursat on 23.04.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserProfileMenuTableCellViewModelProtocol: ViewModel {
    var type: BehaviorRelay<UserProfileMenuRowType> { get }
}

final class UserProfileMenuTableCellViewModel: UserProfileMenuTableCellViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    var type: BehaviorRelay<UserProfileMenuRowType>
    
    // MARK: - Lifecycle
    
    init(router: Router, type: UserProfileMenuRowType) {
        self.router = router
        self.type = .init(value: type)
    }
    
    // MARK: - Methods
}

