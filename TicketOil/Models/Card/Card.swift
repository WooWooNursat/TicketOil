//
//  Card.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation

struct Card: Codable, Equatable {
    let number: String
    let cardHolderName: String
    let expirationDate: Date
    let cvv: String
}
