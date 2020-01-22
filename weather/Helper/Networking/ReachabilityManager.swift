//
//  ReachabilityManager.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit
import Alamofire
import Localize_Swift

/// This class was designed and implemented to check internet connection
class ReachabilityManager {
    
    /// Reachability Manager
    let reachabilityManager: NetworkReachabilityManager = {
        return NetworkReachabilityManager()!
    }()
    
    /// Application window
    private let window: UIWindow
    
    /// init
    init(window: UIWindow) {
        self.window = window
    }
    
    /// Start Network Reachability Observer
    func startNetworkReachabilityObserver() {
        reachabilityManager.listener = { status in
            switch status {
            case .notReachable:
                print("The network is not reachable")
            case .unknown:
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
            }
        }
        
        reachabilityManager.startListening()
    }
    
    /// Stop Network Reachability Observer
    func stopNetworkReachabilityObserver() {
        reachabilityManager.listener = nil
        reachabilityManager.stopListening()
    }
    
    /// Check connection
    ///
    /// - Returns: boolean value
    func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
