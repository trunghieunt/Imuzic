//
//  AppDelegate+Config.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/7/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension AppDelegate {
    
    func configLibrary() {
        
    }
    
    
    func loadDefaultViewController() {
        let tabbarVC = TabbarVC.loadFromNib()
        let tabbarNav = DarkNavigationController.init(rootViewController: tabbarVC)
        window?.rootViewController = tabbarNav
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let ytActionUrl = url.absoluteString.replacingOccurrences(of: "shareUrl://", with: "")
        if ytActionUrl.contains("add") {
            let ytUrl = url.absoluteString.replacingOccurrences(of: "add/", with: "")
            NotificationCenter.default.post(name: kNotiLoadVideo, object: nil,
                                            userInfo: [
                                                "action": ActionType.add.rawValue,
                                                "url": ytUrl]
            )
        } else if ytActionUrl.contains("play"){
            let ytUrl = url.absoluteString.replacingOccurrences(of: "play/", with: "")
            NotificationCenter.default.post(name: kNotiLoadVideo, object: nil,
                                            userInfo: [
                                                "action": ActionType.playAndAdd.rawValue,
                                                "url": ytUrl]
            )
        } else if ytActionUrl.contains("youtube"){
            NotificationCenter.default.post(name: kNotiLoadVideo, object: nil,
                                            userInfo: [
                                                "action": ActionType.none.rawValue,
                                                "url": ytActionUrl]
            )
        }

        return true
    }
}

