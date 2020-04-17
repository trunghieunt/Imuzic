//
//  SettingXCell.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/16/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import StoreKit
import PopupDialog

class SettingXCell: UITableViewCell {
    @IBOutlet weak var tableView: UITableView!
    
    var cellItems : [SettingEnum] = [.reStorePurhase, .rateApp, .feedBack, .privacy, .shareWithFriend, .aboutApp, .nameApp1]
    var idApp = "1508572677"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    func configUI() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerCell(SettingCell.className)
        self.tableView.separatorStyle = .none
        self.tableView.layer.cornerRadius = 15
        self.tableView.isScrollEnabled = false
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension SettingXCell: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.className, for: indexPath) as! SettingCell
        cell.configCell(item: cellItems[indexPath.row])
        return cell
    }
}

extension SettingXCell: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        
        switch cellItems[indexPath.row] {
        case .reStorePurhase:
            break
        case .rateApp:
            SKStoreReviewController.requestReview()
            
        case .feedBack:
            let popupVC = PopupDialog.init(viewController: SendEmailPP.loadFromNib(), tapGestureDismissal: false, panGestureDismissal: false)
            topVC.present(popupVC, animated: true, completion: nil)
        case .privacy:
            break
        case .shareWithFriend:
            if let urlStr = NSURL(string: "https://itunes.apple.com/us/app/myapp/id\(self.idApp)?ls=1&mt=8") {
                let objectsToShare = [urlStr]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                
                if UI_USER_INTERFACE_IDIOM() == .pad {
                    if let popup = activityVC.popoverPresentationController {
                        popup.sourceView = topVC.view
                        popup.sourceRect = CGRect(x: topVC.view.frame.size.width / 2, y: topVC.view.frame.size.height / 4, width: 0, height: 0)
                    }
                }
                
                topVC.present(activityVC, animated: true, completion: nil)
            }
        case .nameApp1:
            break
        case .aboutApp:
            break
        }
    }
}
