//
//  PlayerVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/12/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//


import UIKit
import YoutubePlayerView
import FittedSheets

class PlayerVC: UIViewController {
    
    @IBOutlet weak var nameSong: UILabel!
    
    @IBOutlet weak var nameSing: UILabel!
    
    @IBOutlet weak var outletAddFavorite: UIButton!
    
    @IBOutlet weak var viewRight: UIView!
    
    @IBOutlet weak var outletPlayBtn: UIButton!
    
    @IBOutlet weak var outletRepeatBtn: UIButton!
    
    @IBOutlet weak var outletShufeBtn: UIButton!
    
    @IBOutlet weak var youtubeView: YoutubePlayerView!
    
    @IBOutlet weak var headerPanel: UIView!
    
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    
    var youtubePlay = true
    var listSongs : [SongModel] = []
    var listSongFavorites: [SongModel] = []
    var songsearch: SearchModels?
    var index = 0
    var typePlayer = false
    
    
    
    let playerVars: [String: Any] = [
        "controls": 1,
        "modestbranding": 1,
        "playsinline": 1,
        "origin": "https://youtube.com"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerVC.playInBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        configUI()
        configPlayer()
        getFavorite(self.listSongs[index].id ?? "0")
    }
    
    @objc func playInBackground(){
//        self.youtubeView = nil
    }
    
    func configPlayer() {
        youtubeView.loadWithVideoId(listSongs[index].youtubeId!, with: playerVars)
        youtubeView.seek(to: 1.6, allowSeekAhead: true)
        youtubeView.delegate = self
    }
    
    func configUI() {
        self.viewRight.layer.cornerRadius = 13
        self.nameSing.text = self.listSongs[index].artist
        self.nameSong.text = self.listSongs[index].title
        self.typePlayer(repeated: true)
    }
    
    func getFavorite(_ id: String) {
        StoragePlayList.sharedInstance.loadFavorites { (listSongs) in
            self.listSongFavorites = listSongs
            let results = self.listSongFavorites.filter{$0.id == id}
            if results.isEmpty == false{
                self.outletAddFavorite.setImage(UIImage(named: "ic_like_red"), for: .normal)
            }else{
                self.outletAddFavorite.setImage(UIImage(named: "ic_like_white"), for: .normal)
            }
        }
    }
    
    
    @IBAction func actionAddFavorite(_ sender: Any) {
        let results = listSongFavorites.filter{$0.id == self.listSongs[index].id}
        if results.isEmpty == true{
            listSongFavorites.append(self.listSongs[index])
            StoragePlayList.sharedInstance.saveFavorites(listFavorites: listSongFavorites)
            self.outletAddFavorite.setImage(UIImage(named: "ic_like_red"), for: .normal)
        }else{
            let row = listSongFavorites.firstIndex{$0.id == self.listSongs[self.index].id}
            if let _row = row{
                listSongFavorites.remove(at: _row)
            }
            
            
            StoragePlayList.sharedInstance.saveFavorites(listFavorites: self.listSongFavorites)
            self.outletAddFavorite.setImage(UIImage(named: "ic_like_white"), for: .normal)
        }
        
        
    }
    @IBAction func actionAddList(_ sender: Any) {
        let vc = AddSongPopup.loadFromNib()
        vc.songItem = self.listSongs[index]
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        let sheetController = SheetViewController(controller: vc,sizes: [.fullScreen])
        sheetController.topCornersRadius = 15
        topVC.present(sheetController, animated: true, completion: nil)
    }
    
    @IBAction func actionShare(_ sender: Any) {
        self.showToastAtBottom(message: "Coming soon")
    }
    
    @IBAction func actionAlarmClock(_ sender: Any) {self.showToastAtBottom(message: "Coming soon")
    }
    
    @IBAction func actionSpeed(_ sender: Any) {
        self.showToastAtBottom(message: "Coming soon")
    }
    
    @IBAction func actionRepeat(_ sender: Any) {
        self.typePlayer(repeated: true)
    }
    
    @IBAction func actionShufe(_ sender: Any) {
        self.typePlayer(repeated: false)
    }

    
    func typePlayer(repeated: Bool) {
        if repeated{
            outletRepeatBtn.setImage(UIImage(named: "ic_repeat_active"), for: .normal)
            outletShufeBtn.setImage(UIImage(named: "ic_shufe"), for: .normal)
            self.typePlayer = true
        }else{
            outletRepeatBtn.setImage(UIImage(named: "ic_repeat"), for: .normal)
            outletShufeBtn.setImage(UIImage(named: "ic_shufe_active"), for: .normal)
            self.typePlayer = false
        }
    }
    
    @IBAction func actionPlayer(_ sender: Any) {
        if youtubePlay{
            self.outletPlayBtn.setImage(UIImage(named: "ic_pause"), for: .normal)
            self.youtubeView.pause()
            self.youtubePlay = false
        }else{
            self.outletPlayBtn.setImage(UIImage(named: "ic_play"), for: .normal)
            self.youtubeView.play()
            self.youtubePlay = true
        }
        
    }
    
    @IBAction func actionNext(_ sender: Any) {
        if index == self.listSongs.count - 1{
            self.popViewController()
        }else{
            self.index += 1
            self.nameSing.text = self.listSongs[index].artist
            self.nameSong.text = self.listSongs[index].title
            youtubeView.loadWithVideoId(listSongs[index].youtubeId!, with: playerVars)
            getFavorite(self.listSongs[index].id ?? "0")
        }
    }
    
    @IBAction func actionPrev(_ sender: Any) {
        if index == 0{
            self.popViewController()
        }else{
            self.index -= 1
            self.nameSing.text = self.listSongs[index].artist
            self.nameSong.text = self.listSongs[index].title
            youtubeView.loadWithVideoId(listSongs[index].youtubeId!, with: playerVars)
            getFavorite(self.listSongs[index].id ?? "0")
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension PlayerVC: YoutubePlayerViewDelegate{
    func playerViewDidBecomeReady(_ playerView: YoutubePlayerView) {
        playerView.play()
    }
    func playerView(_ playerView: YoutubePlayerView, didChangedToState state: YoutubePlayerState) {
        if state == .ended{
            if typePlayer == false{
                self.index += 1
                self.nameSing.text = self.listSongs[index].artist
                self.nameSong.text = self.listSongs[index].title
            }
            playerView.loadWithVideoId(listSongs[index].youtubeId!, with: playerVars)
            getFavorite(self.listSongs[index].id ?? "0")
        }
        if state == .paused{
            
            self.outletPlayBtn.setImage(UIImage(named: "ic_pause"), for: .normal)
            self.youtubePlay = false
        }
        if state == .unstarted{
            
        }
        if state == .playing{
            self.outletPlayBtn.setImage(UIImage(named: "ic_play"), for: .normal)
            self.youtubePlay = true
        }
    }
    
    func playerViewPreferredInitialLoadingView(_ playerView: YoutubePlayerView) -> UIView? {
        let view = UIView()
        view.backgroundColor = AppColors.osloGray
        return view
    }
    
}
