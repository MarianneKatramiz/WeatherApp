//
//  WeatherForecastViewController.swift
//  weather
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit
import RxSwift

/// This class was designed and implemented to display weather forecast information based on current location
class WeatherForecastViewController: BaseViewController {
    
    /// TableView
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(EmptyTableViewCell.nib, forCellReuseIdentifier: EmptyTableViewCell.identifier)
            tableView.register(CityTableViewCell.nib, forCellReuseIdentifier: CityTableViewCell.identifier)
            tableView.register(WeatherForecastTableViewCell.nib, forCellReuseIdentifier: WeatherForecastTableViewCell.identifier)
            tableView.delegate   = self
            tableView.dataSource = self
        }
    }
    
    let disposeBag = DisposeBag()
    var viewModel: WeatherForecastViewModel!
  
    var message = LocalizableString.loadingKey
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = LocalizableString.step2Key
    }
}

extension WeatherForecastViewController {
   
    /// Set Up View
    override func setupViews() {
        super.setupViews()
        
        // Set up Location
        viewModel.setUpLocation()
    }
    
    /// Binding between the Weather Forecast view controller and the WeatherForecast view model
    override func bindViewModel() {
        super.bindViewModel()
         
        /// display city name in navigation item title
        viewModel.responseCity.subscribe(onNext: { [weak self] _ in
            guard let self = self,
                  let response = self.viewModel.responseCity.value else { return }
            self.navigationItem.title = response
        }).disposed(by: disposeBag)
        
        /// get list of weather forecast info
        viewModel.responseList.subscribe(onNext: { [weak self] _ in
            guard let self = self,
                  let response = self.viewModel.responseList.value else { return }
            self.viewModel.weatherList = response
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        /// get error message
        viewModel.error.subscribe(onNext: { [weak self] _ in
            guard let self = self,
                  let response = self.viewModel.error.value else { return }
            self.message = response.localizedDescription
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

// MARK: - UITableView DataSoruce
extension WeatherForecastViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.weatherList.count != 0 {
            return viewModel.weatherList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.weatherList.count != 0 {
            let list = viewModel.weatherList[section]
            return list.1.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewModel.weatherList.count != 0 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if viewModel.weatherList.count != 0 {
            let list = viewModel.weatherList[section]
            let date = DateUtils.returnDate(value: list.0)

            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 50))
                          
            let titleLabel = UILabel(frame: CGRect(x: 20, y: 10, width: headerView.frame.size.width - 20 - 20, height: 30))
            titleLabel.text      = EEEEFormatter.string(from: date)
            titleLabel.textColor = UIColor.blackColor
            titleLabel.font      = UIFont.boldSystemFont(ofSize: 20)
                          
            headerView.addSubview(titleLabel)
            return headerView
        }
       
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.weatherList.count != 0 {
            return 147
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.weatherList.count != 0 {
            let list = viewModel.weatherList[indexPath.section]
            let item = list.1[indexPath.row]
                
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherForecastTableViewCell") as? WeatherForecastTableViewCell ?? WeatherForecastTableViewCell()
                
            // time
            cell.timeLabel?.text = item.time

            // title
            cell.titleLabel?.text = item.title
                
            // description
            cell.descriptionLabel?.text = item.description
                
            // Temperature
            cell.temperatureLabel?.text = "\(item.temperature)"
            cell.minTempLabel?.text     = "\(item.minTemperature)"
            cell.maxTempLabel?.text     = "\(item.maxTemperature)"
                
            // Wind Speed
            cell.windSpeedLabel?.text   = "\(item.windSpeed)"

            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell") as? EmptyTableViewCell ?? EmptyTableViewCell()
        cell.titleLabel?.text = self.message
        return cell
    }
}

// MARK: - UITableView Delegate
extension WeatherForecastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
