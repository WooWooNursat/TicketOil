//
//  NetworkProvider.swift
//  TicketOil
//
//  Created by Nursat on 20.04.2022.
//

import Alamofire
import Foundation
import PromiseKit

public final class NetworkProvider {
    private let interceptor: Interceptor
    
    public init()
    {
        interceptor = NetworkInterceptor()
    }
    
    internal func upload(data: [String: Any],
                         url: URL) -> Promise<Void>
    {
        Promise { seal in
            let data: (MultipartFormData) -> Void = { formData in
                data.forEach {
                    switch $1 {
                    case let value as Int:
                        formData.append("\(value)".data(using: .utf8)!, withName: $0)
                    case let value as String:
                        formData.append(value.data(using: .utf8)!, withName: $0)
                    case let value as Data:
                        formData.append(value,
                                        withName: $0,
                                        fileName: "\($0).jpg",
                                        mimeType: "image/jpeg")
                    default: break
                    }
                }
            }
            let request = AF.upload(multipartFormData: data,
                                    to: url,
                                    interceptor: interceptor)
            
            request.responseJSON {
                let debugExtras = [
                    "response": $0.debugDescription,
                    "url": url.absoluteString,
                    "request": request.description,
                ]
                
                self.processDataResponse(response: $0,
                                         debugExtras: debugExtras)
                    .done { _ in seal.fulfill(()) }
                    .catch { seal.reject($0) }
            }
        }
    }
    
    internal func upload<T: Codable>(data: [String: Any],
                                     url: URL) -> Promise<T>
    {
        Promise { seal in
            let data: (MultipartFormData) -> Void = { formData in
                data.forEach {
                    switch $1 {
                    case let value as Int:
                        formData.append("\(value)".data(using: .utf8)!, withName: $0)
                    case let value as String:
                        formData.append(value.data(using: .utf8)!, withName: $0)
                    case let value as Data:
                        formData.append(value,
                                        withName: $0,
                                        fileName: "\($0).jpg",
                                        mimeType: "image/jpeg")
                    default: break
                    }
                }
            }
            let request = AF.upload(multipartFormData: data,
                                    to: url,
                                    interceptor: interceptor)
            
            request.responseDecodable(of: T.self, decoder: JSONDecoder.standard) {
                let debugExtras = [
                    "response": $0.debugDescription,
                    "url": url.absoluteString,
                    "request": request.description,
                ]
                switch $0.result {
                case let .failure(error):
                    error.asUserError.withExtras(extras: debugExtras).log()
                    seal.reject(error)
                case let .success(response):
                    seal.fulfill(response)
                }
            }
        }
    }
    
    private func getRequest(_ url: URL,
                            method: HTTPMethod = .post,
                            parameters: Parameters? = nil) -> DataRequest
    {
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding(arrayEncoding: .noBrackets)
            default:
                return JSONEncoding.default
            }
        }()
        
        return AF.request(url,
                          method: method,
                          parameters: parameters,
                          encoding: encoding,
                          interceptor: interceptor)
    }
    
    internal func request(_ url: URL,
                          method: HTTPMethod = .post,
                          parameters: Parameters? = nil) -> Promise<Void>
    {
        let request = getRequest(url, method: method, parameters: parameters)
        return Promise { seal in
            request.responseJSON {
                let debugExtras = [
                    "response": $0.debugDescription,
                    "url": url.absoluteString,
                    "request": request.description,
                ]
                
                self.processDataResponse(response: $0,
                                         debugExtras: debugExtras)
                    .done { _ in seal.fulfill(()) }
                    .catch { seal.reject($0) }
            }
        }
    }
    
    internal func request<T: Codable>(_ url: URL,
                                      method: HTTPMethod = .post,
                                      parameters: Parameters? = nil,
                                      timeoutInterval _: TimeInterval = 30) -> Promise<T>
    {
        let request = getRequest(url, method: method, parameters: parameters)
        
        return Promise { seal in
            request.responseJSON {
                let debugExtras = [
                    "response": $0.debugDescription,
                    "url": url.absoluteString,
                    "request": request.description,
                ]
                
                self.processDataResponse(response: $0,
                                         debugExtras: debugExtras)
                    .then { self.transformDataResponse(response: $0,
                                                       debugExtras: debugExtras) }
                    .done { seal.fulfill($0) }
                    .catch {
                        seal.reject($0)
                    }
            }
        }
    }
    
    private func processDataResponse(response: AFDataResponse<Any>,
                                     debugExtras: [String: String]) -> Promise<[String: Any]>
    {
        Promise { seal in
            switch response.result {
            case let .success(value):
                guard let json = value as? [String: Any] else {
                    return seal.reject(UserError.mobileError(extras: debugExtras).log())
                }
                let message = json["message"] as? String
                
                guard
                    let codeIntegerValue = json["code"] as? Int
                else {
                    return seal.reject(UserError.mobileError(extras: debugExtras).log())
                }
                
                guard
                    let code = Code(rawValue: codeIntegerValue)
                else {
                    if let message = message {
                        return seal.reject(UserError.serverError(message: message))
                    }
                    
                    return seal.reject(UserError.mobileError(extras: debugExtras).log())
                }
                
                switch code {
                case .success:
                    return seal.fulfill(json)
                case .serverError:
                    return seal.reject(UserError.serverError(message: message))
                case .invalidToken:
//                    storageCleaner.clear()
//                    StartAuthorizationRouter.start(message: message ?? UserError.invalidToken().localizedDescription)
                    return seal.reject(UserError.invalidToken())
                }
            case let .failure(error):
                seal.reject(error.asUserError.withExtras(extras: debugExtras).log())
            }
        }
    }
    
    private func transformDataResponse<T: Codable>(response: [String: Any],
                                                   debugExtras: [String: String]) -> Promise<T>
    {
        Promise { seal in
            do {
                guard
                    let data = response.toJSONString.data(using: .utf8)
                else {
                    seal.reject(UserError.mobileError(extras: debugExtras).log())
                    return
                }
                
                let object = try JSONDecoder.standard.decode(T.self, from: data)
                
                seal.fulfill(object)
            } catch {
                seal.reject(UserError.mobileError(with: error, extras: debugExtras).log())
            }
        }
    }
}
