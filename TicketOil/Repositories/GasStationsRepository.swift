//
//  GasStationsRepository.swift
//  TicketOil
//
//  Created by Nursat on 11.06.2022.
//

import Foundation

protocol GasStationsRepository: AnyObject {
    var gasStations: [GasStation] { get set }
}

final class GasStationsRepositoryImpl: GasStationsRepository {
    var gasStations: [GasStation] = [
        GasStation(id: 0, image: URL(string: "www.google.com")!, name: "V-oil №1 на Райымбека", location: Location(address: "Проспект Райымбека, 239", latitude: 43.26424336809044, longitude: 76.90178720617773)),
        GasStation(id: 1, image: URL(string: "www.google.com")!, name: "V-oil № 2 на Витебской", location: Location(address: "Витебская, 48", latitude: 43.192242879042816, longitude: 76.89300751065552))
    ]
}
