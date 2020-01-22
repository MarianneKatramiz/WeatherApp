//
//  DateUtilsTests.swift
//  weatherTests
//
//  Created by Marianne Katramiz on 1/21/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import XCTest
@testable import weather

class DateUtilsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testReturnDateFromTimestamp() -> Date {
        let date = DateUtils.returnDateFromTimestamp(unixTimestamp: 1579604726)
        XCTAssertEqual("\(date)", "2020-01-21 11:05:26 +0000")
        return date
    }
    
    func testReturnDate() {
        let date = self.testReturnDateFromTimestamp()
        let dateString = date.returnDateString()
        XCTAssertEqual(dateString, "21-01-2020")
    }
    
    func testConvertServerDateToLocalTime() {
        let timeString = DateUtils.convertServerDateToLocalTime(value: "2020-01-21 11:05:26", toFormat: "hh:mm a")
        XCTAssertEqual(timeString, "01:05 PM")
    }
}
