//
//  WeatherForecastViewModel.swift
//  weather
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation
import SwiftLocation

/// This class was designed and implemented as view model for Weather Forecast View Controller
class WeatherForecastViewModel: BaseViewModel {
    private let viewController: WeatherForecastViewController

    let disposeBag   = DisposeBag()
    let responseCity = BehaviorRelay<String?>(value: nil)
    
    let responseList = BehaviorRelay<[(String, [WeatherForecastItemModel])]?>(value: nil)
    var weatherList  = [(String, [WeatherForecastItemModel])]()
    let error        = BehaviorRelay<Error?>(value: nil)
    
    var isEnterLocation = false
    
    init(viewController: WeatherForecastViewController) {
        self.viewController = viewController
    }
}

// MARK: - Location
extension WeatherForecastViewModel {

    /// Check user current location
    func setUpLocation() {
        
        LocationManager.shared.onAuthorizationChange.add({ value in
            if value == .available {
                self.getCurrentLocation()
            }
        })
        LocationManager.shared.requireUserAuthorization(.whenInUse)
               
        if LocationManager.state == .denied {
            let error = APIClient.shared.createError(statusCode: 0, message: LocalizableString.noLocationAccessKey)
            self.error.accept(error)

            UIAlertController.init(title: LocalizableString.accessLocationKey,
                                   message: LocalizableString.accessLocationMessageKey,
                                   preferredStyle: .alert)
                .addCancel()
                .addDefault(title: LocalizableString.allowKey, handler: { _ in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                })
                .present(on: self.viewController)
        } else if LocationManager.state == .available {
            self.getCurrentLocation()
        }
    }
    
    /// get long and lat of the current location
    func getCurrentLocation() {
        let req = LocationManager.shared.locateFromGPS(.continous, accuracy: .city) { result in
            switch result {
            case .failure(let error):
                print("Received error: \(error)")
            case .success(let location):
                self.getWeatherForecast(locationCoordinate: location.coordinate)
            }
        }
        req.stop()
    }
}

// MARK: - API Call
extension WeatherForecastViewModel {
   
    /// API Call to get weather forecase information base on user current location
    func getWeatherForecast(locationCoordinate: CLLocationCoordinate2D) {
    
        APIClient.shared.callLink(endLink: LinksUtils.getWeatherForecast(locationCoordinate: locationCoordinate))
            .subscribe(
                onNext: { responseString in
                    decodeCodable(responseString: responseString, type: WeatherForecastModel.Result.self, successHandler: { (result) in
                        self.parseResult(result: result)
                    }, errorHandler: { (error) in
                        self.error.accept(error)
                    })
                }, onError: { error in
                    self.error.accept(error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    /// Parsing the result
    func parseResult(result: WeatherForecastModel.Result) {
        let weatherList = result.list
            .map { response in
                response.map(WeatherForecastItemModel.init)
            }
              
        let groupedList = self.groupedByDate(weatherList ?? [])
        let sortedGroupedList = groupedList
            .map { ($0, $1) }
            .sorted() { ($0.0).compare($1.0) == .orderedAscending }

        self.responseList.accept(sortedGroupedList)
        self.responseCity.accept(result.city?.name ?? "")
    }
    
    /// grouping the result by date
    func groupedByDate(_ lists: [WeatherForecastItemModel]) -> [String: [WeatherForecastItemModel]] {
        let empty: [String: [WeatherForecastItemModel]] = [:]
        let filterLists = lists.reduce(into: empty) { acc, cur in
            let date    = cur.date
            let newDate = date.returnDateString()
            
            let existing = acc[newDate] ?? []
            acc[newDate] = existing + [cur]
        }
        return filterLists
    }
}
