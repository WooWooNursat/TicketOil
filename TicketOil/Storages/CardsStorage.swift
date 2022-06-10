//
//  CardsStorage.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation

protocol CardsStorage: AnyObject {
    var cards: [Card] { get set }
    var preferredCard: Card? { get set }
}

extension Storage: CardsStorage {
    private enum Keys: String {
        case cards
        case preferredCard
    }
    
    var cards: [Card] {
        get {
            do { return try cache(model: [Card].self).object(forKey: Keys.cards.rawValue) }
            catch { return [] }
        }
        set {
            try? cache(model: [Card].self).setObject(newValue, forKey: Keys.cards.rawValue)
        }
    }
    
    var preferredCard: Card? {
        get {
            guard let user = user else { return nil }
            
            do {
                return try cache(model: [Int: Card].self).object(forKey: Keys.preferredCard.rawValue)[user.id]
            } catch {
                return cards.last
            }
        }
        set {
            guard let user = user else { return }
            
            do {
                var preferredCards = try cache(model: [Int: Card].self).object(forKey: Keys.preferredCard.rawValue)
                preferredCards[user.id] = newValue
                try? cache(model: [Int: Card].self).setObject(preferredCards, forKey: Keys.preferredCard.rawValue)
            } catch {
                guard let preferredCard = newValue else { return }

                try? cache(model: [Int: Card].self).setObject([user.id: preferredCard], forKey: Keys.preferredCard.rawValue)
            }
        }
    }
}
