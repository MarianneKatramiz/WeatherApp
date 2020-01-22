//
//  BaseViewController.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// This class was designed and implemented as parent class for every view controller
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupViews()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = ""
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

extension BaseViewController {
   
    /// Set Up View
    @objc func setupViews() {
        // Override this method to setup viewController's subviews
        
        hideBackButtonTitle()
    }
    
    /// Bind View Model
    @objc func bindViewModel() {
        // Override this method to bind viewModel to viewController
    }
    
    /// Hide back button title
    private func hideBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
