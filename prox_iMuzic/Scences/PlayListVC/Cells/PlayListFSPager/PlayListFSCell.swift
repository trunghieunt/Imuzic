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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    func configUI() {
        img.layer.cornerRadius = 15
        viewShadow.layer.cornerRadius = 15
    }
    
    func configCell() {
        
    }
}
