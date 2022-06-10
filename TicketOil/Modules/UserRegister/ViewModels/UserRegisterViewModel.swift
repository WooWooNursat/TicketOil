//
//  UserRegisterViewModel.swift
//  TicketOil
//
//  Created by Nursat on 20.04.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserRegisterViewModelProtocol: ViewModel {
    var phone: String { get set }
    var password: String { get set }
    var isEnabled: BehaviorRelay<Bool> { get }
    
    func register()
}

final class UserRegisterViewModel: UserRegisterViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    private let userManager: UserManager
    var phone: String = "+7"
    var password: String = ""
    var isEnabled: BehaviorRelay<Bool>
    
    // MARK: - Lifecycle
    
    init(router: Router, userManager: UserManager) {
        self.router = router
        self.userManager = userManager
        isEnabled = .init(value: false)
    }
    
    // MARK: - Methods
    
    func register() {
        userManager.user = User(id: .random(in: (0...20)), phone: phone)
        let context = UserRegisterRouter.RouteType.profileEdit
        router.enqueueRoute(with: context)
    }
}

