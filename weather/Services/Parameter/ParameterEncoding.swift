//
//  ParameterEncoding.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// decode the codable
/// - Parameters:
///   - responseString: response as String
///   - type: codable type
///   - successHandler: handle success
///   - errorHandler: handle error
func decodeCodable <T: Codable>(responseString: String?, type: T.Type, successHandler: @escaping(_ details: T) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
    guard let responseData = responseString?.data(using: .utf8), let decodedJson = try? JSONDecoder().decode(T.self, from: responseData) else {
        let error = APIClient.shared.createError(statusCode: 0, message: LocalizableString.noResultKey)
        errorHandler(error)
        return
    }
    successHandler(decodedJson)
}
