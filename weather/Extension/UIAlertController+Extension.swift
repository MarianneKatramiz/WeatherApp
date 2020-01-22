//
//  UIAlertController+Extension.swift
//  weather
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

extension UIAlertController {
        
    /// Alert Type
    /// - Parameters:
    ///   - title: alert title as String
    ///   - message: alert message as String
    static func alert(title: String = "", message: String = "") -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
        
    /// default Basic Actions
    /// - Parameters:
    ///   - title: alert title action as String
    ///   - handler:alert handler action as UIAlertAction
    @discardableResult
    func addDefault(title: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: title, style: .default, handler: handler))
        return self
    }
    
    /// destructive Basic Actions
    /// - Parameters:
    ///   - title: alert title action as String
    ///   - handler: alert handler action as UIAlertAction
    @discardableResult
    func addDestructive(title: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: title, style: .destructive, handler: handler))
        return self
    }
    
    /// Cancel Basic Actions
    /// - Parameters:
    ///   - title: alert title action as String
    ///   - handler: alert handler action as UIAlertAction
    @discardableResult
    func addCancel(title: String? = LocalizableString.cancelKey,
                   handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: title, style: .cancel, handler: handler))
        return self
    }
    
    /// Button Ok Basic Actions
    /// - Parameter handler: alert handler action as UIAlertAction
    @discardableResult
    func addOk(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: LocalizableString.okKey, style: .default, handler: handler))
        return self
    }
        
    /// Presentation
    /// - Parameter presentingViewController: presentation View Controller
    func present(on presentingViewController: UIViewController) {
        presentingViewController.present(self, animated: true, completion: nil)
    }
}
