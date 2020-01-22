//
//  APIClient.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

/// This class was designed and implemented for api call
class APIClient: NSObject {

    /// Shared Instance
    static let shared = APIClient()
    
    /// init
    private override init() {
        super.init()
    }
    
    /// Returns the correct session manager to run this request.
    private func getSessionManager() -> Alamofire.SessionManager {
        return AlamofireSessionManager.shared
    }
    
    /// API Call
    /// - Parameters:
    ///   - endLink: end link as String
    ///   - method: http method as CoreNetworking.HTTPMethod
    func callLink( endLink: String,
                   method: CoreNetworking.HTTPMethod = .GET) -> Observable<String> {
        
        // Check internet connection
        if !appDelegate.applicationCoordinator.reachabilityManager.isConnected() {
            SwiftMessagesBuilder.shared.showErrorMessage(message: LocalizableString.noInternetKey)
            return self.returnErrorNoResult()
        }
        
        let urlString: String? = "\(LinksUtils.getBaseUrl())\(endLink)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        guard let url: URL = URL(string: urlString ?? "") else {
            return self.returnErrorNoResult()
        }
        var request = URLRequest.init(url: url)
        request.timeoutInterval = TimeInterval(Constants.apiCallTimeout)
        request.cachePolicy     = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod      = method.rawValue
        
        let sessionManager = self.getSessionManager()
        return Observable.create { observer in
            sessionManager.request(request)
                .responseJSON { response in
                    let statusCode = response.response?.statusCode
                   
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            let responseString = String(data: data, encoding: .utf8)
                            if statusCode == 200 || statusCode == 201 {
                                observer.on(.next(responseString ?? ""))
                                observer.on(.completed)
                            } else {
                                decodeCodable(responseString: responseString, type: ErrorResponse.self, successHandler: { (result) in
                                    observer.on(.error(self.createError(statusCode: statusCode ?? 0, message: result.message ?? "")))
                                }, errorHandler: { (error) in
                                    observer.on(.error(error))
                                })
                            }
                        } else {
                            observer.on(.error(self.createError(statusCode: statusCode ?? 0, message: LocalizableString.noResultKey)))
                        }
                    case .failure(let error):
                        observer.on(.error(error))
                    }
            }
            return Disposables.create()
        }
    }
    
    /// Return Error
    func returnErrorNoResult() -> Observable<String> {
        return Observable.create { observer in
            observer.on(.error(self.createError(statusCode: 0, message: LocalizableString.noResultKey)))
            return Disposables.create()
        }
    }
        
    /// Create Error
    /// - Parameters:
    ///   - statusCode: Status Code as Integer
    ///   - message: error message as String
    func createError(statusCode: Int, message: String) -> Error {
        let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: message]) as Error
        return error
    }
}
