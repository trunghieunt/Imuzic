//
//  AboutVC.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/27/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import SafariServices

class AboutVC: UIViewController {
    
    @IBOutlet var lbVersion:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "About"
        
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as AnyObject
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as AnyObject
        lbVersion.text = "Version: \(version).\(build)"
        
    }

    @IBAction func openHomePage(){
        
        let urlStr = "https://proxteam.github.io/anime/"
        let sf = SFSafariViewController(url: URL(string:urlStr)!)
        self.present(sf, animated: true, completion: nil)
        
    }
   

}
