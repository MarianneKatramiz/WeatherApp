//
//  MemoryTests.swift
//  weatherTests
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import XCTest
@testable import weather

class MemoryTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSaveLanguage() {
        
        // Given
        let lang = "ar"
        
        // When
        Memory.saveLanguage(value: lang)
        let memoryLanguage = Memory.getLanguage()

        // Then
        XCTAssertEqual(lang, memoryLanguage)
    }
    
    func testDeleteLanguage() {
        
        // Given
        let lang = "en"
        
        // When
        Memory.deleteLanguage()
        let memoryLanguage = Memory.getLanguage()

        // Then
        XCTAssertEqual(lang, memoryLanguage)
    }
}
