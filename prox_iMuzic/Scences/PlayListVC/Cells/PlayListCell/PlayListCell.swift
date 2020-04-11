//
//  PlayListCell.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/10/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class PlayListCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameList: UILabel!
    
    @IBOutlet weak var overView: UILabel!
    
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        // Initialization code
    }

    func configUI() {
        self.overView.layer.opacity = 0.75
        img.layer.cornerRadius = 15
        self.viewCell.layer.cornerRadius = 15
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
