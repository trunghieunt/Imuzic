//
//  SettingVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/7/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    func configUI() {
        self.tableView.registerCell(SettingXCell.className)
        self.tableView.registerCell(BannerSettingVC.className)
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        if #available(iOS 11.0, *) {

        }else{
            let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets(
                top: 0, left: 0,
                bottom: self.tabBarController!.tabBar.frame.height + 40, right: 0)
             self.tableView.contentInset = adjustForTabbarInsets
             self.tableView.scrollIndicatorInsets = adjustForTabbarInsets
        }
    }

}


extension SettingVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cellBanner = tableView.dequeueReusableCell(withIdentifier: BannerSettingVC.className, for: indexPath) as! BannerSettingVC
            return cellBanner
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingXCell.className, for: indexPath) as! SettingXCell
            return cell
        }
    }
    
    
}
