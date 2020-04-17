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

    @IBOutlet weak var outletbtn: UIButton!
    var doneRemove: ()->() = { }
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
    func configCell(item: SearchModels) {
        if let strUrl = item.thumb {
            let url = URL(string:strUrl)
            self.img.kf.setImage(with: url)
        }else if let strUrl = item.thumbnail{
            let url = URL(string:strUrl)
            self.img.kf.setImage(with: url)
        }else{
            self.img.image = UIImage(named: "image_thumb")
        }
        self.nameList.text = item.title
        self.overView.text = item.author
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
    
    func configCellPP(){
        self.viewCell.backgroundColor = UIColor("#F1F1F1")
        self.nameList.textColor = .black
        self.overView.textColor = .black
        self.contentView.backgroundColor = .white
        self.outletbtn.isHidden = true
        self.layoutIfNeeded()
    }
    @IBAction func removeItems(_ sender: Any) {
        self.doneRemove()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
