//
//  DateUtils.swift
//  weather
//
//  Created by Marianne Katramiz on 1/20/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// This class was designed and implemented for date utils
class DateUtils: NSObject {

    /// Convert Timestamp to Date
    /// - Parameter unixTimestamp: timestamp  value as integer
    static func returnDateFromTimestamp(unixTimestamp: Int) -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        return date
    }
    
    ///  Convert String into Date
    /// - Parameters:
    ///   - value: value as String
    ///   - format:  format as String
    static func returnDate(value: String, format: String = FormatDate.ddMMYYYY) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: value) ?? Date()
    }

    /// Convert string into date then convert date into local date
    /// - Parameters:
    ///   - value: value as String
    ///   - format: format as String
    ///   - toFormat: to Format as String
    static func convertServerDateToLocalTime(value: String, format: String = FormatDate.fullDateFormat, toFormat: String = FormatDate.fullDateFormatAPM) -> String {
          
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale     = Locale.init(identifier: "en")
        dateFormatter.timeZone   = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: value) // Create date from string
          
        // Change to a readable time format and change to local time zone
        dateFormatter.dateFormat = toFormat
        dateFormatter.timeZone   = NSTimeZone.local
        dateFormatter.locale     = Locale.current
        let timeStamp = dateFormatter.string(from: date ?? Date())
          
        return timeStamp
    }
}
