//
//  ItemsBannerCell.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import FSPagerView

class ItemsBannerCell: FSPagerViewCell {

    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    func configUI() {
        self.layer.cornerRadius = 16
        self.viewTitle.layer.cornerRadius = 6
        self.viewTitle.layer.borderColor = UIColor.white.cgColor
        self.viewTitle.layer.borderWidth = 0.4
    }
    func configCell(item:PlayListModels) {
        if let strUrl = item.playlistThumbMedium {
            let url = URL(string:strUrl)
            self.img.kf.setImage(with: url)
        }else{
            self.img.image = UIImage(named: "imgPlaceholder")
        }
        self.musicTitle.text = item.channelTitle
    }

}
