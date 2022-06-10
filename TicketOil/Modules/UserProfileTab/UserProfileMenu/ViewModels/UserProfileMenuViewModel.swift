//
//  UserProfileMenuViewModel.swift
//  TicketOil
//
//  Created by Nursat on 22.04.2022.
//

import Foundation
import RxSwift
import RxCocoa
import Intercom

protocol UserProfileMenuViewModelProtocol: ViewModel {
    var cellViewModels: [[UserProfileMenuTableCellViewModelProtocol]] { get }
    var update: BehaviorRelay<Void> { get }
    
    func openMyCards()
    func openUserProfileEdit()
    func inviteFriend()
    func openIntercom()
    func logout()
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
    
    func openMyCards() {
        let context = UserProfileMenuRouter.RouteType.myCards
        router.enqueueRoute(with: context)
    }
    
    func openUserProfileEdit() {
        let context = UserProfileMenuRouter.RouteType.userProfileEdit
        router.enqueueRoute(with: context)
    }
    
    func inviteFriend() {
        let context = UserProfileMenuRouter.RouteType.inviteFriend
        router.enqueueRoute(with: context)
    }

    func openIntercom() {
        Intercom.presentMessenger()
    }
    
    func logout() {
        let context = UserProfileMenuRouter.RouteType.logout
        router.enqueueRoute(with: context)
    }
}

