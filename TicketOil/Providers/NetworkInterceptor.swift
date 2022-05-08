//
//  NetworkInterceptor.swift
//  TicketOil
//
//  Created by Nursat on 20.04.2022.
//

import Alamofire

final class NetworkInterceptor: Interceptor {
    enum RetryReason {
        case limitExceeded
        case notIdempotent
        case networkFailed
    }
    
    private let retryCount = 3
    private let retryDelay = 0.5
    
    private var headers: [String: String] {
        var headers: [String: String] = [
            "device-type": "iOS",
        ].compactMapValues { $0 }
        
//        if let token = authorizationCredentialsStorage.tokenString {
//            headers["auth-token"] = token
//        }
        
//        if let location = userLocationStorage.location?.clCoordinate2D {
//            headers["device-latitude"] = location.latitude.description
//            headers["device-longitude"] = location.longitude.description
//        }
        
        return headers
    }
    
    init()
    {
        super.init()
    }
    
    override func adapt(_ urlRequest: URLRequest, for _: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var adaptedUrlRequest = urlRequest
        headers.forEach { adaptedUrlRequest.headers.add(name: $0.key, value: $0.value) }
        
        switch urlRequest.method {
        case .some(.get):
            adaptedUrlRequest.timeoutInterval = 10
        default:
            adaptedUrlRequest.timeoutInterval = 30
        }
        
        completion(.success(adaptedUrlRequest))
    }
    
    override func retry(_ request: Request, for _: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let reason = retryReason(for: request, dueTo: error)
        switch reason {
        case .networkFailed:
            completion(.retryWithDelay(retryDelay))
        case .limitExceeded, .none, .notIdempotent:
            completion(.doNotRetry)
        }
    }
    
    private func retryReason(for request: Request, dueTo error: Error) -> RetryReason? {
        guard request.request?.method == .get else { return .notIdempotent }
        
        if request.retryCount > retryCount {
            return .limitExceeded
        } else if let errorCode = (error.asAFError?.underlyingError as? URLError)?.code, RetryPolicy.defaultRetryableURLErrorCodes.contains(errorCode) {
            return .networkFailed
        } else {
            return .none
        }
    }
}
