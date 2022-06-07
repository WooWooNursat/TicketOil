//
//  Location.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation
import CoreLocation

struct Location: Codable {
    let address: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}
