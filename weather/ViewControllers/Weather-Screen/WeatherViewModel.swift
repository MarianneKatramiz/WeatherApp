//
//  WeatherViewModel.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// This class was designed and implemented as view model for Weather view controller
class WeatherViewModel: BaseViewModel {
    private let viewController: WeatherViewController

    let disposeBag = DisposeBag()
  
    let response     = BehaviorRelay<WeatherModel.Result?>(value: nil)
    var weatherArray = [WeatherModel.Result]()
   
    let error = BehaviorRelay<Error?>(value: nil)
    
    /// init
    init(viewController: WeatherViewController) {
        self.viewController = viewController
    }
    
    /// Return array of cities
    func returnCityArray(by city: String) -> [String] {
        let newCity   = city.replace(target: "،", withString: ",") // Convert comma arabic to comma english
        let cityArray = newCity.split(separator: ",").map(String.init)
        return cityArray
    }
    
    /// Check city array counter that must reach the minimum city entered by the user
    func checkMinCityCounter(by cityArray: [String]) -> Bool {
        return cityArray.count < Constants.minEnterCity
    }
}

// MARK: - API Call
extension WeatherViewModel {
   
    /// API Call to get weather of the city
    func getWeather(city: String) {
                   
        APIClient.shared.callLink(endLink: LinksUtils.getWeather(for: city))
            .subscribe(
                onNext: { responseString in
                    decodeCodable(responseString: responseString, type: WeatherModel.Result.self, successHandler: { (result) in
                        self.response.accept(result)
                    }, errorHandler: { (error) in
                        self.error.accept(error)
                    })
                }, onError: { error in
                    self.error.accept(error)
                }
            )
            .disposed(by: disposeBag)
    }
}

