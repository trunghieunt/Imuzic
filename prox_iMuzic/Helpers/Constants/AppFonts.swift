//
//  AppFonts.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation
import UIKit

struct AppFonts {
    static func coreSansGS45Regular(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "CoreSansGS-45Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func coreSansGS65Bold(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "CoreSansGS-65Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func coreSansGS65BoldItalic(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "CoreSansGS-65BoldItalic", size: size) ?? UIFont.italicSystemFont(ofSize: size)
    }
    
    static func coreSansGS55Medium(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "CoreSansGS-55Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func coreSansGS45RegularItalic(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "CoreSansGS-45RegularItalic", size: size) ?? UIFont.italicSystemFont(ofSize: size)
    }
    
    static func coreSansGS35Light(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "CoreSansGS-35Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    static func coreSansGS25ExtraLight(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "CoreSansGS-25ExtraLight", size: size) ?? UIFont.systemFont(ofSize: size, weight: .ultraLight)
    }
    
    static func effra_Trial_Rg1(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "Effra_Trial_Rg1", size: size) ?? UIFont.systemFont(ofSize: size, weight: .ultraLight)
    }
    static func Silom(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "Silom", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    static func Verdana(_ size: CGFloat) -> UIFont{
        return UIFont.init(name: "Verdana Negreta", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
}

