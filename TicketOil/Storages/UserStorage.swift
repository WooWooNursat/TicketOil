//
//  UserStorage.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation

protocol UserStorage: AnyObject {
    var user: User? { get set }
}

extension Storage: UserStorage {
    private enum Keys: String {
        case user
    }
    
    var user: User? {
        get { try? cache(model: User.self).object(forKey: Keys.user.rawValue) }
        set {
            if let user = newValue {
                try? cache(model: User.self).setObject(user, forKey: Keys.user.rawValue)
            } else {
                try? cache(model: User.self).removeObject(forKey: Keys.user.rawValue)
            }
        }
    }
}
