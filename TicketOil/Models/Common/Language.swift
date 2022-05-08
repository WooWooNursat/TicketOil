//
//  Language.swift
//  TicketOil
//
//  Created by Nursat on 17.04.2022.
//

import Foundation
import SwiftDate

public enum Language: String, CaseIterable {
    case ru
    case en
    
    private var country: String {
        switch self {
        case .ru: return "ru"
        case .en: return "gb"
        }
    }
    
    public var flag: String {
        let base: UInt32 = 127397
        var s = ""
        for v in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
    }
    
    public var name: String {
        switch self {
        case .ru: return "Русский"
        case .en: return "English"
        }
    }
    
    public var locale: Locales {
        switch self {
        case .en: return .english
        case .ru: return .russian
        }
    }
}
