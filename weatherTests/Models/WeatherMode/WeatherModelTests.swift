//
//  WeatherModelTests.swift
//  weatherTests
//
//  Created by Marianne Katramiz on 1/20/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import XCTest
@testable import weather

class WeatherModelTests: XCTestCase {

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
    
    func testWeatherModelDecode() {
       
        if let path = Bundle(for: classForCoder).url(forResource: "WeatherModel", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let responseString = String(data: data, encoding: .utf8)

               decodeCodable(responseString: responseString, type: WeatherModel.Result.self, successHandler: { (result) in
                    XCTAssertNotNil(result)
                    XCTAssertEqual(result.name ?? "", "Dubai")
                }, errorHandler: { (error) in
                    XCTAssertNotNil(error)
                    XCTFail(error.localizedDescription)
                    XCTAssertEqual(error.localizedDescription, "No results")
                })
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
}
