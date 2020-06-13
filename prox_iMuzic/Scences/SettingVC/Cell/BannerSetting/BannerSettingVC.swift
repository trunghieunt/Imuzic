//
//  BannerSettingVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/16/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class BannerSettingVC: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func upGrade(_ sender: Any) {
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        
        let alert = UIAlertController(title: "Features will be updated later", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        topVC.present(alert, animated: true, completion: nil)
    }
    
}
