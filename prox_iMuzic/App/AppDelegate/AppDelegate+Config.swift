//
//  AppDelegate+Config.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/7/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func configLibrary() {

    }
    
    /// Kiểm tra user đã đăng nhập hay chưa để hiển thị view tương ứng
    func loadDefaultViewController() {
//        User.shared.loadFromLocal()
//        if User.shared.isLogged {
//            let tabbarVC = TabbarVC.loadFromNib()
//            window?.rootViewController = tabbarVC
//        } else {
//            let tabbarVC = LoginVC.loadFromNib()
//            window?.rootViewController = tabbarVC
//
        let tabbarVC = TabbarVC.loadFromNib()
        let tabbarNav = DarkNavigationController.init(rootViewController: tabbarVC)
            window?.rootViewController = tabbarNav
//        }
    }
}

