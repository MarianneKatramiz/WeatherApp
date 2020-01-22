//
//  ResponseError.swift
//  weather
//
//  Created by Marianne Katramiz on 1/20/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// Model struct for error response
struct ErrorResponse: Codable {
    let cod: String?
    let message: String?
}
