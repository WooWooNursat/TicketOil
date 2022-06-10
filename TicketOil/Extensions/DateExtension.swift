//
//  DateExtension.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation

extension Date {
    init?(
        calendar: Calendar = .current,
        timeZone: TimeZone? = .utc,
        year: Int,
        month: Int? = nil
    ) {
        let dateComponents = DateComponents(
            calendar: calendar,
            timeZone: timeZone,
            year: year,
            month: month
        )
        guard let date = dateComponents.date else {
            return nil
        }
        
        self = date
    }
}

extension TimeZone {
    static let utc = TimeZone(abbreviation: "UTC")
}
