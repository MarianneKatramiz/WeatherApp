//
//  MainViewController.swift
//  weather
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit
import RxSwift

/// This class was designed and implemented as main view controller to navigate between step 1 and step 2
class MainViewController: BaseViewController {
    
    /// TableView
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate   = self
            tableView.dataSource = self
            tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.identifier)
        }
    }
    
    let disposeBag = DisposeBag()
    var viewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = LocalizableString.weatherKey
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UITableView DataSoruce
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell ?? TableViewCell()
        
        if indexPath.row == 0 {
            cell.titleLabel?.text = LocalizableString.step1Key
        } else {
            cell.titleLabel?.text = LocalizableString.step2Key
        }
        return cell
    }
}

// MARK: - UITableView Delegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            self.viewModel.openWeatherScreen()
        } else {
            self.viewModel.openWeatherForecastScreen()
        }
    }
}
