//
//  UserManager.swift
//  TicketOil
//
//  Created by Nursat on 11.06.2022.
//

import Foundation

protocol UserManager: AnyObject {
    var user: User? { get set }
}

final class UserManagerImpl: UserManager {
    var user: User? {
        get { storage.user }
        set { storage.user = newValue }
    }
    
    private let storage: UserStorage
    
    init(storage: UserStorage) {
        self.storage = storage
    }
}
