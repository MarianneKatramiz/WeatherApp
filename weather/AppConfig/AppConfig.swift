//
//  AppConfig.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// This class was designed and implemented for application onfiguration
class AppConfig: NSObject {

    /// Name of the storyboard
    var mainStoryboard = UIStoryboard()
    
    /// Shared instance
    static let shared = AppConfig()
    
    /// init
    private override init() {
        super.init()
    }
    
    /// default init value
    func initDefaultValue() {
       
        // init Language
        self.initGetLanguage()
        
        // init Storyboard
        self.initStoryboard()
    }

    /// init device language
    func initGetLanguage() {
        
        // get device language
        let deviceCurrentLanguage = NSLocale.current.languageCode ?? "en"
        
        // Save device language in keychain
        Memory.saveLanguage(value: deviceCurrentLanguage)
    }
    
    /// init storyboard
    func initStoryboard() {
        mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    }
}
