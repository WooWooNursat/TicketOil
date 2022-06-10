//
//  User.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation

struct User: Codable {
    let id: Int
    let phone: String
    let image: URL
    let name: String
    let surname: String
    let carNumber: String
    let gasolineType: String
}
