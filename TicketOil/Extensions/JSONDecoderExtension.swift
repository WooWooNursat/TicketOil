//
//  JSONDecoderExtension.swift
//  TicketOil
//
//  Created by Nursat on 20.04.2022.
//

import Foundation

extension JSONDecoder {
    static var standard: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customISO8601
        
        return decoder
    }
}

extension JSONEncoder {
    static var standard: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        return encoder
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder.standard.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw UserError.standard()
        }
        return dictionary
    }
}

extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601 = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let options: [ISO8601DateFormatter.Options] = [[.withInternetDateTime,
                                                        .withFractionalSeconds],
                                                       [.withInternetDateTime]]
        for option in options {
            formatter.formatOptions = option
            if let date = formatter.date(from: string) {
                return date
            }
        }
        
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
