//
//  UserError.swift
//  TicketOil
//
//  Created by Nursat on 20.04.2022.
//

import Foundation
import PromiseKit

public final class UserError: LocalizedError {
    private enum ErrorType: Equatable {
        case standard
        case ignorable
        case serverError(message: String?)
        case mobileError
        case mobileErrorWith(error: Error)
        case invalidToken
        case other(error: Error)
        
        static func == (lhs: UserError.ErrorType, rhs: UserError.ErrorType) -> Bool {
            switch (lhs, rhs) {
            case (.ignorable, .ignorable):
                return true
            default:
                return false
            }
        }
    }
    
    private let type: ErrorType
    private var extras: [String: Any]?
    private lazy var errorId = self.generateErrorId()
    
    public lazy var isIgnorable: Bool = self.type == .ignorable
    
    public var errorDescription: String? {
        switch type {
        case .standard:
            return ""
        case let .serverError(message):
            return message
        case .mobileError, .mobileErrorWith:
            return "\(errorId)"
        case let .other(error):
            return error.localizedDescription
        case .invalidToken:
            return ""
        case .ignorable:
            return nil
        }
    }
    
    public var failureReason: String? {
        switch type {
        case let .mobileErrorWith(error):
            return String(reflecting: error)
        case let .other(error):
            return String(reflecting: error)
        default:
            return nil
        }
    }
    
    public func withExtras(extras: [String: Any]) -> UserError {
        self.extras = extras
        return self
    }
    
    private func generateErrorId() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return "I\(String((0 ..< 3).map { _ in letters.randomElement()! }))-\(String((0 ..< 4).map { _ in letters.randomElement()! }))"
    }
    
    @discardableResult
    func log() -> UserError {
        if let reason = failureReason
        {
            print("[⛔️] \(reason)")
        }
        
        return self
    }
    
    private init(_ type: ErrorType, extras: [String: Any]? = nil) {
        self.type = type
        self.extras = extras
    }
    
    public static func serverError(message: String?, extras: [String: Any]? = nil) -> UserError {
        return .init(.serverError(message: message), extras: extras)
    }
    
    public static func mobileError(extras: [String: Any]? = nil) -> UserError {
        return .init(.mobileError, extras: extras)
    }
    
    public static func mobileError(with error: Error, extras: [String: Any]? = nil) -> UserError {
        return .init(.mobileErrorWith(error: error), extras: extras)
    }
    
    public static func ignorable() -> UserError {
        return .init(.ignorable)
    }
    
    public static func invalidToken() -> UserError {
        return .init(.invalidToken)
    }
    
    public static func standard() -> UserError {
        return .init(.standard)
    }
    
    fileprivate static func other(error: Error) -> UserError {
        return .init(.other(error: error))
    }
}

public extension Error {
    var asUserError: UserError {
        guard let userError = self as? UserError
        else { return .other(error: self) }
        
        return userError
    }
}

public extension Resolver {
    func reject() {
        reject(UserError.ignorable())
    }
}
