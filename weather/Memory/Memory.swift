//
//  Memory.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit
import Localize_Swift

/// This class was designed and implemented to saving values in Keychain
class Memory: NSObject {

    /// save language
    /// - Parameter value: language value as String
    static func saveLanguage(value: String) {
        keychain.set(value, forKey: KeychainKeys.langKKey)
    }
    
    /// get language
    static func getLanguage() -> String {
        return keychain.get(KeychainKeys.langKKey) ?? "en"
    }
    
    /// delete language
    static func deleteLanguage() {
        keychain.delete(KeychainKeys.langKKey)
    }
}
