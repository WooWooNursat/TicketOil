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
    var name: String = ""
    var surname: String = ""
    var carNumber: String = ""
    var gasolineType: String?
}
