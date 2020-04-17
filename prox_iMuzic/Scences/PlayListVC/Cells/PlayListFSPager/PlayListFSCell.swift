//
//  PlayListFSCell.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/10/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import FSPagerView

class PlayListFSCell: FSPagerViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var viewShadow: UIView!
    
    @IBOutlet weak var nameList: UILabel!
    
    @IBOutlet weak var overView: UILabel!
    
     var doneRemove: ()->() = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    func configUI() {
        img.layer.cornerRadius = 15
        viewShadow.layer.cornerRadius = 15
    }
    
    func configCell(item: PlayListLocalModels) {
        if item.imageUrl == ""{
            self.img.image = UIImage(named: "image_thumb")
        }else{
            if let strUrl = item.imageUrl {
                let url = URL(string:strUrl)
                self.img.kf.setImage(with: url)
            }else{
                self.img.image = UIImage(named: "image_thumb")
            }
        }
        self.nameList.text = item.title
        self.overView.text = (item.songNumber ?? "0") + " songs"
    }
    
    @IBAction func actionRemove(_ sender: Any) {
        self.doneRemove()
    }
    
}
