//
//  Storage.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Cache
import KeychainAccess

public final class Storage {
    private enum Keys: String {
        case diskConfigName = "Disk Config"
    }
    
    public func cache<T: Codable>(model: T.Type) -> Cache.Storage<String, T> {
        let diskConfig = DiskConfig(name: Keys.diskConfigName.rawValue)
        let config = MemoryConfig(expiry: .never)
        let storage = try! Cache.Storage<String, T>(diskConfig: diskConfig,
                                                    memoryConfig: config,
                                                    transformer: TransformerFactory.forCodable(ofType: model))
        return storage
    }
    
    public let keychain = Keychain(service: Keys.diskConfigName.rawValue).accessibility(.always)
    
    public func clear() {
        
    }
}
