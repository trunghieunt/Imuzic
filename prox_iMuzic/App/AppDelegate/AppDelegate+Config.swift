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
    
//    func configAVAudioSession() {
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
//            print("Playback OK")
//            try AVAudioSession.sharedInstance().setActive(true)
//            print("Session is Active")
//        } catch {
//            print(error)
//        }
//    }
}

