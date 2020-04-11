//
//  GenderColl.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class GenderColl: UICollectionViewCell {

    @IBOutlet weak var titleGender: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 33
        
        // Initialization code
    }
    
    func configCell(name: String?) {
        self.titleGender.text = name
         self.titleGender.sizeToFit()
        self.setNeedsLayout()
    }


}
