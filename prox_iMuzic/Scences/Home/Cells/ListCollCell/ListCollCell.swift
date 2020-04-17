//
//  ListCollCell.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import Kingfisher

class ListCollCell: UICollectionViewCell {

    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNumSong: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
        configUI()
        // Initialization code
    }
    func configUI() {
        self.lblNumSong.layer.opacity = 0.75
        self.gradientView.colors = [UIColor(red: 0.033, green: 0.033, blue: 0.033, alpha: 0), UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
        
    }
    
    func configCellMore(item: PlayListModels) {
        if let strUrl = item.playlistThumbMedium {
            let url = URL(string:strUrl)
            self.img.kf.setImage(with: url)
        }else{
            self.img.image = UIImage(named: "image_thumb")
        }
        self.lblTitle.text = "More"
        self.lblNumSong.text = ""
    }

    
    func configCell(item: PlayListModels) {
        if let strUrl = item.playlistThumbMedium {
            let url = URL(string:strUrl)
            self.img.kf.setImage(with: url)
        }else{
            self.img.image = UIImage(named: "image_thumb")
        }
        self.lblTitle.text = item.title
        self.lblNumSong.text = item.channelTitle
    }

}
