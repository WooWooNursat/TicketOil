//
//  CardsRepository.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation

protocol CardsRepository: AnyObject {
    var cards: [Card] { get set }
    var preferredCard: Card? { get set }
}

final class CardsRepositoryImpl: CardsRepository {
    private let storage: CardsStorage
    
    var cards: [Card] {
        get { storage.cards }
        set { storage.cards = newValue }
    }
    
    var preferredCard: Card? {
        get { storage.preferredCard }
        set { storage.preferredCard = newValue}
    }
    
    init(storage: CardsStorage) {
        self.storage = storage
    }
}
