//
//  ApplicationCoordinator.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

/// This class was designed and implemented as application coordinator
class ApplicationCoordinator: NSObject {
    
    lazy var reachabilityManager: ReachabilityManager = {
        let manager = ReachabilityManager(window: window)
        return manager
    }()
    
    let window: UIWindow
    
    /// init
    init(window: UIWindow) {
        self.window = window
    }
    
    /// Start the app
    func start() {
                
        // Reachability Manager
        reachabilityManager.startNetworkReachabilityObserver()
        
        // IQKeybaordManager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarTintColor = .blueColor
        
        // app config
        AppConfig.shared.initDefaultValue()
        
        // Customizing NavigationItem fonts (title, subtitle, barButtons)
        UINavigationBar.appearance().tintColor = UIColor.blackColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blackColor,
                                                            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        // Start App
        self.startApplication()
    }
    
    /// Start the app
    func startApplication() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window else { return }

        let viewController = AppConfig.shared.mainStoryboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController ?? MainViewController()
        let viewModel = MainViewModel(viewController: viewController)
        viewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
