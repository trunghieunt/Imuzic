//
//  SettingEnum.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/16/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//


import Foundation


enum SettingEnum {
    case reStorePurhase
    case rateApp
    case feedBack
    case privacy
    case shareWithFriend
    case nameApp1
    case aboutApp
    
    var title :String{
        switch self {
        case .rateApp:
            return "Rating app"
        case .feedBack:
            return "Feedback"
        case .shareWithFriend:
            return "Share with friend"
        case .nameApp1:
            return "Name app1"
        case .aboutApp:
            return "About app"
        case .reStorePurhase:
            return "Restore purchase"
        case .privacy:
            return "Privacy & Terms"
        }
    }
    
    var img : String{
        switch self {
        case .rateApp:
            return "ic_menu_rate"
        case .feedBack:
            return "ic_menu_feedback"
        case .shareWithFriend:
            return "ic_menu_share"
        case .nameApp1:
            return "ic_upgrade"
        case .aboutApp:
            return "ic_menu_about"
        case .reStorePurhase:
            return "ic_menu_restore"
        case .privacy:
             return "ic_menu_terms"
        }
    }
    
    
}

