//
//  LocalizableString.swift
//  weather
//
//  Created by Marianne Katramiz on 1/20/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// This class was designed and implemented for localizable string 
class LocalizableString: NSObject {

    static let noInternetKey = "no_internet".localized()
    static let noResultKey   = "no_results".localized()
    static let loadingKey    = "loading_weather".localized()

    static let noLocationAccessKey      = "no_location_access".localized()
    static let accessLocationKey        = "access_location".localized()
    static let accessLocationMessageKey = "access_location_message".localized()
    static let allowKey = "allow".localized()
   
    static let cancelKey = "Cancel".localized()
    static let okKey     = "Ok".localized()
    
    static let weatherKey = "weather".localized()
    static let step1Key   = "step1".localized()
    static let step2Key   = "step2".localized()
    
    static let searchPlaceholderKey = "search_placeholder".localized()
    
    static let minTempKey = "min_temperature".localized()
    static let maxTempKey = "max_temperature".localized()
    static let windKey    = "wind_speed".localized()
  
    static let citiesMessageKey = "cities_messsage".localized()
    static let notifyKey        = "notify".localized()
}
