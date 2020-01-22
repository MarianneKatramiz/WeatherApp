//
//  AppConfigTests.swift
//  weatherTests
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import XCTest
@testable import weather

class AppConfigTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIntStoryboard() {
        AppConfig.shared.mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        XCTAssertNotNil(AppConfig.shared.mainStoryboard)
    }
}
