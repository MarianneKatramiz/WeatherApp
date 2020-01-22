//
//  MainViewModel.swift
//  weather
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// This class was designed and implemented as view model for main view controller
class MainViewModel: BaseViewModel {
    private let viewController: MainViewController

    /// init
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    /// Open Weather View Controller
    func openWeatherScreen() {
        let viewController = AppConfig.shared.mainStoryboard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController ?? WeatherViewController()
        let viewModel = WeatherViewModel(viewController: viewController)
        viewController.viewModel = viewModel
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Open Weather forecast View Controller
    func openWeatherForecastScreen() {
        let viewController = AppConfig.shared.mainStoryboard.instantiateViewController(withIdentifier: "WeatherForecastViewController") as? WeatherForecastViewController ?? WeatherForecastViewController()
        let viewModel = WeatherForecastViewModel(viewController: viewController)
        viewController.viewModel = viewModel
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
