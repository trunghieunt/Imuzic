//
//  SongItemsCell.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/11/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import FittedSheets

class SongItemsCell: UITableViewCell {
    @IBOutlet weak var outletFavorite: UIButton!
    
    @IBOutlet weak var viewCell: UIView!
    
    @IBOutlet weak var NameSong: UILabel!
    
    @IBOutlet weak var NameSing: UILabel!
    
    @IBOutlet weak var tagCCell: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    var songItem: SongModel?
    var favorite = false
     var reload: ()->() = {}
    
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
        
        self.songItem = listSong
        
        if let strUrl = listSong.thumbnail {
            let url = URL(string:strUrl)
            self.img.kf.setImage(with: url)
        }else{
            self.img.image = UIImage(named: "image_thumb")
        }
    }
    
    func configCell(listSong: SongModel, favorite: Bool) {
        self.NameSing.text = listSong.artist
        self.NameSong.text = listSong.title
        self.tagCCell.text = listSong.youtubeDuration
        
        self.songItem = listSong
        
        if let strUrl = listSong.thumbnail {
            let url = URL(string:strUrl)
            self.img.kf.setImage(with: url)
        }else{
            self.img.image = UIImage(named: "image_thumb")
        }
        
        self.favorite = favorite
        self.outletFavorite.setImage(UIImage(named: "Combined"), for: .normal)
    }
    
    
    @IBAction func actionAddList(_ sender: Any) {
        if favorite{
            let vc = FavoritePopup.loadFromNib()
            vc.songItem = self.songItem
            vc.reload = {[weak self]in
                self?.reload()
            }
            guard let topVC = UIApplication.topViewController() else {
                return
            }
            let sheetController = SheetViewController(controller: vc,sizes: [.fullScreen])
            sheetController.topCornersRadius = 15
            topVC.present(sheetController, animated: true, completion: nil)
        }else{
            let vc = AddSongPopup.loadFromNib()
            vc.songItem = self.songItem
            guard let topVC = UIApplication.topViewController() else {
                return
            }
            let sheetController = SheetViewController(controller: vc,sizes: [.fullScreen])
            sheetController.topCornersRadius = 15
            topVC.present(sheetController, animated: true, completion: nil)
        }
    }
}
