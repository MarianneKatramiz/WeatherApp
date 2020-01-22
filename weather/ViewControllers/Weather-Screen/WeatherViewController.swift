//
//  WeatherViewController.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit
import RxSwift

/// This class was designed and implemented to search for multiple cities 
class WeatherViewController: BaseViewController {
    
    /// Text Field to search for cities
    @IBOutlet weak var cityNameTextField: UITextField! {
        didSet {
            cityNameTextField.textColor     = UIColor.blackColor
            cityNameTextField.font          = UIFont.systemFont(ofSize: 18)
            cityNameTextField.placeholder   = LocalizableString.searchPlaceholderKey
            cityNameTextField.returnKeyType = .search
            cityNameTextField.delegate = self
        }
    }

    /// TableView
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(EmptyTableViewCell.nib, forCellReuseIdentifier: EmptyTableViewCell.identifier)
            tableView.register(WeatherTableViewCell.nib, forCellReuseIdentifier: WeatherTableViewCell.identifier)
            tableView.delegate   = self
            tableView.dataSource = self
        }
    }
    
    /// Refresh controller for table view
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.blackColor
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    let disposeBag = DisposeBag()
    var viewModel: WeatherViewModel!

    var errorMessage = LocalizableString.noResultKey
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = LocalizableString.step1Key
    }
}

extension WeatherViewController {
   
    /// Set Up View
    override func setupViews() {
        super.setupViews()

        self.tableView.refreshControl = refreshControl
        
        self.searchForCityName()
    }
    
    /// Binding between the Weather view controller and the weather view model
    override func bindViewModel() {
        super.bindViewModel()
        
        /// get weather array
        viewModel.response.subscribe(onNext: { [weak self] _ in
            guard let self = self,
                  let response = self.viewModel.response.value else { return }
            self.viewModel.weatherArray.append(response)
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        // get error message
        viewModel.error.subscribe(onNext: { [weak self] _ in
            guard let self = self,
                  let error = self.viewModel.error.value else { return }
            self.errorMessage = error.localizedDescription
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    /// Pull down to refresh
    @objc func pullToRefresh() {
       self.refreshControl.endRefreshing()
    }
}

// MARK: -
extension WeatherViewController: UITextFieldDelegate {
    
    func searchForCityName() {
        
        /// Text field did end keyboard do API Call
        self.cityNameTextField.rx.controlEvent(.editingDidEnd)
            .asObservable()
            .map { self.cityNameTextField.text }
            .subscribe(onNext: { city in
                self.viewModel.weatherArray = []
                self.errorMessage = LocalizableString.noResultKey
                
                if let city = city {
                    if !city.isEmpty {
                        let cityArray = self.viewModel.returnCityArray(by: city)
                        self.fetchWeather(by: cityArray)
                    } else {
                        self.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
        
        /// Resign text field
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .subscribe(onNext: {
                self.cityNameTextField.resignFirstResponder()
            }).disposed(by: disposeBag)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        let array = self.viewModel.returnCityArray(by: updatedText)
        if array.count < Constants.maxEnterCity {
            return true
        } else {
            return false
        }
    }
    
    /// fetch for weather in the cities
    func fetchWeather(by city: [String]) {
        
        if viewModel.checkMinCityCounter(by: city) {
            UIAlertController.init(title: LocalizableString.notifyKey,
                                   message: LocalizableString.citiesMessageKey,
                                   preferredStyle: .alert)
                .addOk()
                .present(on: self)
            return
        }
        
        city.forEach { (cityName) in
            let contentOffset = CGPoint(x: 0, y: -self.refreshControl.frame.height)
            self.tableView.setContentOffset(contentOffset, animated: true)
            self.refreshControl.layoutIfNeeded()
            self.refreshControl.beginRefreshing()

            viewModel.getWeather(city: cityName.trim())
        }
    }
}

// MARK: - UITableView DataSoruce
extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.viewModel.weatherArray.count != 0 {
            return self.viewModel.weatherArray.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.weatherArray.count != 0 {
            let weatherItem = self.viewModel.weatherArray[indexPath.section]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as? WeatherTableViewCell ?? WeatherTableViewCell()
            
            // Name
            cell.nameLabel?.text = weatherItem.name
            
            // description
            if let item = weatherItem.weather?.first {
                cell.descriptionLabel?.text = item.description ?? ""
            } else {
                cell.descriptionLabel?.text = ""
            }
            
            // Temp
            cell.minTempLabel?.text = "\(LocalizableString.minTempKey) \(String(format: "%.1f", weatherItem.main?.temp_min ?? 0.0))\(Constants.degree)"
            cell.maxTempLabel?.text = "\(LocalizableString.maxTempKey) \(String(format: "%.1f", weatherItem.main?.temp_max ?? 0.0))\(Constants.degree)"

            // Wind Speed
            cell.windSpeedLabel?.text = "\(LocalizableString.windKey) \(String(format: "%.1f", weatherItem.wind?.speed ?? 0.0)) \(Constants.windSpeedUnits)"

            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell") as? EmptyTableViewCell ?? EmptyTableViewCell()
        cell.titleLabel?.text = self.errorMessage
        return cell
    }
}

// MARK: - UITableView Delegate
extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
