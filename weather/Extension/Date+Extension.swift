//
//  Date+Extension.swift
//  weather
//
//  Created by Marianne Katramiz on 1/20/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

extension Date {
    
    /// Convert date to String
    func returnDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormatDate.ddMMYYYY
        return dateFormatter.string(from: self)
    }
}
