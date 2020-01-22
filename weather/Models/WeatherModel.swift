//
//  WeatherModel.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// Model struct for weather
struct WeatherModel: Codable {

    struct Result: Codable {
        let message: String?
        let name: String?
        let weather: [Weather]?
        let main: MainValue?
        let wind: WindValue?
    }

    struct Weather: Codable {
        let main: String?
        let description: String?
    }

    struct MainValue: Codable {
        let temp: Double?
        let temp_min: Double?
        let temp_max: Double?
    }

    struct WindValue: Codable {
        let speed: Double?
    }
}
