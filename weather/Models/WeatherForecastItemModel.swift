//
//  WeatherForecastItemModel.swift
//  weather
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// Model struct for each item in weather forecast
struct WeatherForecastItemModel {
    
    private let item: WeatherForecastModel.Item
    
    init(item: WeatherForecastModel.Item) {
        self.item = item
    }
    
    var date: Date {
        return DateUtils.returnDateFromTimestamp(unixTimestamp: item.dt)
    }

    var time: String {
        return DateUtils.convertServerDateToLocalTime(value: item.dt_txt ?? "", toFormat: "hh:mm a")
    }
    
    var temperature: String {
        return "\(String(format: "%.1f", item.main?.temp ?? 0.0))\(Constants.degree)"
    }
    
    var minTemperature: String {
        return "\(LocalizableString.minTempKey) \(String(format: "%.1f", item.main?.temp_min ?? 0.0))\(Constants.degree)"
    }
    
    var maxTemperature: String {
        return "\(LocalizableString.maxTempKey) \(String(format: "%.1f", item.main?.temp_max ?? 0.0))\(Constants.degree)"
    }
    
    var windSpeed: String {
        return "\(LocalizableString.windKey) \(String(format: "%.1f", item.wind?.speed ?? 0.0)) \(Constants.windSpeedUnits)"
    }
    
    var title: String {
        guard let title = item.weather?.first?.main else { return "" }
        return title
    }
    
    var description: String {
        guard let description = item.weather?.first?.description else { return "" }
        return description
    }
}
