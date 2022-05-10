//
//  AuthHomeViewModel.swift
//  TicketOil
//
//  Created by Nursat on 17.04.2022.
//


protocol AuthHomeViewModelProtocol: ViewModel {
    func registration()
    func login()
}

final class AuthHomeViewModel: AuthHomeViewModelProtocol {
    // MARK: - Variables
    
    var router: Router
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: - Methods
    
    func registration() {
        let context = AuthHomeRouter.RouteType.register
        router.enqueueRoute(with: context)
    }
    
    func login() {
        let context = AuthHomeRouter.RouteType.mainTabBar
        router.enqueueRoute(with: context)
    }
}

