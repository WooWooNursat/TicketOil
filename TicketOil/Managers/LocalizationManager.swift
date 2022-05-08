//
//  LocalizationManager.swift
//  TicketOil
//
//  Created by Nursat on 17.04.2022.
//

import Foundation
import SwiftDate

public protocol LocalizationManager {
    var language: Language { get set }
    var locale: Locales { get }
}

public final class LocalizationManagerImplementation: LocalizationManager {
    public enum Constants {
        static let backendHeader = "accept-language"
        static let defaultsKey = "AppleLanguages"
    }
    
    public var acceptLanguage: String {
        return language.rawValue
    }
    
    public var locale: Locales { language.locale }
    
    public var language: Language {
        get {
            guard let languageCode = UserDefaults.standard.array(forKey: Constants.defaultsKey) as? [String],
                  let language = Language(rawValue: languageCode[0])
            else {
                guard let preferredLanguage = NSLocale.preferredLanguages.first?.resized(newSize: 2),
                      let language = Language(rawValue: preferredLanguage) else { return .en }
                
                return language
            }
            
            return language
        }
        
        set {
            L10n.bundle = Bundle(path: Bundle.main.path(forResource: newValue.rawValue,
                                                        ofType: "lproj")!)
            SwiftDate.defaultRegion = Region()
            UserDefaults.standard.set([newValue.rawValue], forKey: Constants.defaultsKey)
            UserDefaults.standard.synchronize()
        }
    }
}

public extension Bundle {
    static var localizedBundle: Bundle {
        guard
            let localizationManager = DIResolver.resolve(LocalizationManager.self),
            let path = Bundle.main.path(forResource: localizationManager.language.rawValue, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else {
            return Bundle.main
        }
        
        return bundle
    }
}
