//
//  WeatherViewModelTests.swift
//  weatherTests
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import weather

class WeatherViewModelTests: XCTestCase {

    var viewModel: WeatherViewModel!

    let disposeBag = DisposeBag()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let viewController = AppConfig.shared.mainStoryboard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController ?? WeatherViewController()
        let viewModel = WeatherViewModel(viewController: viewController)
        viewController.viewModel = viewModel
        self.viewModel = viewModel
        
        XCTAssertNotNil(viewController)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testReturnCityArray() {
        let cityString = "Dubai, London, Lebanon"
        let cityArray  = viewModel.returnCityArray(by: cityString)
        XCTAssertEqual("\(cityArray.count)", "3")
    }
    
    func testReturnCityArrayArabic() {
        let cityString = "لبنان، دبي، كندا"
        let cityArray  = viewModel.returnCityArray(by: cityString)
        XCTAssertEqual("\(cityArray.count)", "3")
    }
    
    func testCheckMinCityCounter() {
        let cityArray = viewModel.returnCityArray(by: "Dubai, London, Lebanon")
        let value = viewModel.checkMinCityCounter(by: cityArray)
        XCTAssertFalse(value)
    }
    
    func testCheckMinCityCounterFailure() {
        let cityArray = viewModel.returnCityArray(by: "Dubai")
        let value = viewModel.checkMinCityCounter(by: cityArray)
        XCTAssertTrue(value)
    }
}

// MARK: - Test API Call 
extension WeatherViewModelTests {
    
    func testGetWeatherSuccess() {
        
        let apiSuccess = expectation(description: "get weather finished successfully")
        
        viewModel.response.skip(1).subscribe(onNext: { _ in
            apiSuccess.fulfill()
        }).disposed(by: disposeBag)
        
        viewModel.getWeather(city: "Dubai")
        
        wait(for: [apiSuccess], timeout: 30)
    }
    
    func testGetWeatherFailure() {

        let apiError = expectation(description: "get weather failed")

        viewModel.error.skip(1).subscribe(onNext: { _ in
            apiError.fulfill()
        }).disposed(by: disposeBag)

        viewModel.getWeather(city: "D")

        wait(for: [apiError], timeout: 30)
    }
}
