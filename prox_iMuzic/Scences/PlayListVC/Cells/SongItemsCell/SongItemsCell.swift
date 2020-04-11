//
//  SongItemsCell.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/11/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class SongItemsCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    
    @IBOutlet weak var NameSong: UILabel!
    
    @IBOutlet weak var NameSing: UILabel!
    
    @IBOutlet weak var tagCCell: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    func configUI() {
        self.viewCell.roundCorners([.bottomLeft,.topLeft], radius: 40)
        self.img.roundCorners(.allCorners, radius: 40)
    }
    func configCell(listSong: SongModel) {
        self.NameSing.text = listSong.artist
        self.NameSong.text = listSong.title
        self.tagCCell.text = listSong.youtubeDuration
        
        if let strUrl = listSong.thumbnail {
            let url = URL(string:strUrl)
            self.img.kf.setImage(with: url)
        }else{
            self.img.image = UIImage(named: "image_thumb")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionAddList(_ sender: Any) {
    }
}
