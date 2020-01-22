//
//  ErrorResponseTests.swift
//  weatherTests
//
//  Created by Marianne Katramiz on 1/20/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import XCTest
@testable import weather

class ErrorResponseTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testErrorResponse() {
        let testSuccessfulJSON: JSON = ["cod": "404", "message": "city not found"]
        XCTAssertNotNil(ErrorResponse(json: testSuccessfulJSON))
    }
    
    func testErrorResponseDecode() {
        let responseString = "{\"cod\": \"404\", \"message\": \"city not found\"}"
        decodeCodable(responseString: responseString, type: ErrorResponse.self, successHandler: { (result) in
            XCTAssertEqual(result.message ?? "", "city not found")
        }, errorHandler: { (error) in
            XCTAssertEqual(error.localizedDescription, "No results")
        })
    }
}

// MARK: - extension ErrorResponse
private extension ErrorResponse {
    
    init?(json: JSON) {
        guard let cod     = json["cod"] as? String,
              let message = json["message"] as? String else {
                return nil
        }
        self.init(cod: cod, message: message)
    }
}
