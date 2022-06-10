//
//  ArrayExtension.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation

extension Array {
    func get(index: Int) -> Element? {
        if index >= 0, index < count {
            return self[index]
        } else {
            return nil
        }
    }
}
