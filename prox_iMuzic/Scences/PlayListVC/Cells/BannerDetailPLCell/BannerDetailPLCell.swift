//
//  BannerDetailPLCell.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/11/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class BannerDetailPLCell: UITableViewCell {

    
    @IBOutlet weak var viewGradient: GradientView!
    
    @IBOutlet weak var titleListPlay: UILabel!
    
    @IBOutlet weak var channelTitle: UILabel!
    
    @IBOutlet weak var overView: UILabel!
    
    @IBOutlet weak var outletPlay: UIButton!
    
    @IBOutlet weak var outletPlayRandom: UIButton!
    
    @IBOutlet weak var img: UIImageView!
    
    var playerType: (Bool)->() = {_ in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    func configUI()  {
        self.viewGradient.colors = [UIColor(red: 0.033, green: 0.033, blue: 0.033, alpha: 0), UIColor(red:0.04, green:0.04, blue:0.09, alpha:1.00)]
        self.outletPlay.layer.cornerRadius = 12
        self.outletPlayRandom.layer.cornerRadius = 12
        
    }

    func configCell(playList: PlayListModels) {
        self.titleListPlay.text = playList.title
        self.channelTitle.text = playList.channelTitle
        self.overView.text = playList.playlistSubTitle
        
        if let strUrl = playList.playlistThumbMedium {
            let url = URL(string:strUrl)
            self.img.kf.setImage(with: url)
        }else{
            self.img.image = UIImage(named: "image_thumb")
        }
    }
    func configCell(playList: PlayListLocalModels) {
        self.titleListPlay.text = playList.title
        self.channelTitle.text = (playList.songNumber ?? "0") + " songs"
        self.overView.text = ""
        
        if let strUrl = playList.imageUrl {
            let url = URL(string:strUrl)
            self.img.kf.setImage(with: url)
        }else{
            self.img.image = UIImage(named: "image_thumb")
        }
    }
    
    func configCell(playList: GenresModels) {
        self.titleListPlay.text = playList.name
        self.channelTitle.text = playList.country
        self.overView.text = ""
        var image = ["banner_Gender_1", "banner_Gender_2", "banner_Gender_3", "banner_Gender_4"]
        
        self.img.image = UIImage(named: image.randomElement() ?? "banner_Gender_1")
        
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionBack(_ sender: Any) {
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        topVC.popViewController()
    }
    @IBAction func actionPlay(_ sender: Any) {
        self.playerType(true)
    }
    @IBAction func actionRandomPlay(_ sender: Any) {
        self.playerType(false)
    }
}
