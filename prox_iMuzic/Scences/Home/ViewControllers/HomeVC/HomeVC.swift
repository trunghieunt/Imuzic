//
//  HomeVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/7/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var listCell : [EnumsHome] = [.banner,.menu,.genner]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTB()
        // Do any additional setup after loading the view.
    }
    func configTB() {
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.registerCell(BannerCell.className)
        self.tableView.registerCell(MenuCell.className)
        self.tableView.registerCell(GenderCell.className)
        

        if #available(iOS 11.0, *) {

        }else{
            let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets(
                top: 0, left: 0,
                bottom: self.tabBarController!.tabBar.frame.height + 40, right: 0)
             self.tableView.contentInset = adjustForTabbarInsets
             self.tableView.scrollIndicatorInsets = adjustForTabbarInsets
        }

    }
    

    
    @IBAction func actionSearch(_ sender: Any) {
    }
    
    
}

extension HomeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch listCell[indexPath.row] {
            
        case .banner:
            
            let cellBanner = tableView.dequeueReusableCell(withIdentifier: BannerCell.className, for: indexPath) as! BannerCell
            return cellBanner
            
        case .menu:
            
            let cellMenu = tableView.dequeueReusableCell(withIdentifier: MenuCell.className, for: indexPath) as! MenuCell
            return cellMenu
        case .genner:
            let cellGender = tableView.dequeueReusableCell(withIdentifier: GenderCell.className, for: indexPath) as! GenderCell
            return cellGender
        }
        
        
    }
    
    
}
