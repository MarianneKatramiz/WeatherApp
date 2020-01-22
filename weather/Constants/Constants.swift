//
//  Constants.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit
import KeychainSwift

let appDelegate = UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
let keychain    = KeychainSwift()

/// Constants
struct Constants {
    static let apiCallTimeout = 120
    
    static let minEnterCity = 3
    static let maxEnterCity = 8
    
    static let degree         = "°"
    static let windSpeedUnits = "m/s"
}

/// Date Format
struct FormatDate {
    static let ddMMYYYY          = "dd-MM-yyyy"
    static let fullDateFormat    = "yyyy-MM-dd HH:mm:ss"
    static let fullDateFormatAPM = "yyyy-MM-dd hh:mm a"
}

/// Keychain Key
struct KeychainKeys {
    static let langKKey = "lang_KKey"
}
