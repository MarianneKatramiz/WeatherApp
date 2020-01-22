//
//  WeatherForecastModel.swift
//  weather
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// Model struct for Weather Forecast
struct WeatherForecastModel: Codable {

    struct Result: Codable {
        let list: [Item]?
        let city: City?
    }
    
    struct Item: Codable {
        let dt: Int
        let main: WeatherModel.MainValue?
        let weather: [WeatherModel.Weather]?
        let dt_txt: String?
        let wind: WeatherModel.WindValue?
    }
    
    struct City: Codable {
        let name: String?
    }
}
