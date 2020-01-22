//
//  ReachabilityManagerTests.swift
//  weatherTests
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import XCTest
@testable import weather

class ReachabilityManagerTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsConnected() {
        let isConnected = appDelegate.applicationCoordinator.reachabilityManager.isConnected()
        XCTAssertTrue(isConnected)
    }
}
