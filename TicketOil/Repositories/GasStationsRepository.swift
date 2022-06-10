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
        GasStation(id: 0, image: URL(string: "www.google.com")!, name: "V-oil №1 на Райымбека", location: Location(address: "asrgseergr", latitude: 43.26591283256827, longitude: 76.86710297943574)),
        GasStation(id: 1, image: URL(string: "www.google.com")!, name: "V-oil № 2 на Ташкентской", location: Location(address: "argresegree", latitude: 43.32754740582985, longitude: 76.90921718656105))
    ]
}
