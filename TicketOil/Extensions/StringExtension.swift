//
//  StringExtension.swift
//  TicketOil
//
//  Created by Nursat on 17.04.2022.
//

import Foundation

public extension String {
    mutating func resize(newSize: Int) {
        while count > newSize {
            removeLast()
        }
    }
    
    func resized(newSize: Int) -> String {
        var string = self
        string.resize(newSize: newSize)
        return string
    }
}
