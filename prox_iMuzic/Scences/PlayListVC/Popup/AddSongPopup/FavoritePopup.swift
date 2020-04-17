//
//  FavoritePopup.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/15/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import FittedSheets

class FavoritePopup: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var titleSong: UILabel!
    
    @IBOutlet weak var lblsinger: UILabel!
    
    @IBOutlet weak var viewPP: UIView!
    
    var songItem: SongModel?
    
    var reload: ()->() = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    func configUI() {
        if let strUrl = songItem?.thumbnail{
            let url = URL(string:strUrl)
            self.img.kf.setImage(with: url)
        }else{
            self.img.image = UIImage(named: "image_thumb")
        }
        titleSong.text = songItem?.title
        lblsinger.text = songItem?.artist
        img.layer.cornerRadius = 50
    }

    @IBAction func actionUnLike(_ sender: Any) {
        StoragePlayList.sharedInstance.loadFavorites { (listSongs) in
            var listSongs = listSongs
            let row = listSongs.firstIndex{$0.id == self.songItem?.id}
            listSongs.remove(at: row ?? 10000)
            
            StoragePlayList.sharedInstance.saveFavorites(listFavorites: listSongs)
            self.showToastAtBottom(message: "Success!!!")
            self.reload()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        

    }
    @IBAction func actionAddPlayList(_ sender: Any) {
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
