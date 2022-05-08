//
//  DictionaryExtension.swift
//  TicketOil
//
//  Created by Nursat on 20.04.2022.
//

import Foundation

extension Dictionary {
    // возращает dictionary в String формате
    var toJSONString: String {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: [])
        return String(data: jsonData, encoding: .utf8)!
    }
}
