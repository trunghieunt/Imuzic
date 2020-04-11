//
//  TabbarVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/7/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class TabbarVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        setupNav()
    }
    func setupNav()  {
        self.navigationController?.navigationBar.isHidden = true
    }
    func setupTabbar() {
        let homeVC = HomeVC.loadFromNib()
        homeVC.tabBarItem = createTabbarItem(title: "Home", imageName: "home-run")
        let playListVC = PlayListVC.loadFromNib()
        playListVC.tabBarItem = createTabbarItem(title: "Play List", imageName: "ic_audio")
        let favoriteVC = FavoritesVC.loadFromNib()
        favoriteVC.tabBarItem = createTabbarItem(title: "Favorites", imageName: "ic_passion")
        let settingVC = SettingVC.loadFromNib()
        settingVC.tabBarItem = createTabbarItem(title: "Setting", imageName: "ic_settings")
        
        
        let tabBarController = BubbleTabBarController()
        
        //        self.viewControllers = [homeNav, playListNav, favoriteNav, settingNav]
        let viewControllers = [homeVC, playListVC,favoriteVC ,settingVC]
        tabBarController.viewControllers = viewControllers
        let tabbarBL = tabBarController.tabBar
        tabbarBL.tintColor = AppColors.primary
        tabbarBL.shadowImage = UIImage.init()
        tabbarBL.backgroundImage = UIImage.init()
        tabbarBL.isTranslucent = false
        tabbarBL.layer.masksToBounds = false
        tabbarBL.isTranslucent = true
        tabbarBL.barStyle = .blackOpaque
        tabbarBL.itemPositioning = .centered
        tabbarBL.itemWidth = 40
        tabbarBL.itemSpacing = 38
        tabBarController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: AppFonts.coreSansGS45Regular(12), NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        tabBarController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: AppFonts.coreSansGS45Regular(18), NSAttributedString.Key.foregroundColor: AppColors.primary], for: .selected)
        
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    func createTabbarItem(title: String, imageName: String) -> UITabBarItem {
        let _image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let tabbarItem = UITabBarItem.init(title: title, image: _image, selectedImage: UIImage.init(named: imageName))
        return tabbarItem
    }
    
}
