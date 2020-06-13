//
//  PlayerVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/12/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//


import UIKit
import FittedSheets
import XCDYouTubeKit

enum ActionType: String {
    case none = "none"
    case play = "play"
    case add = "add"
    case playAndAdd = "playAndAdd"
}

class PlayerVC: UIViewController {
    @IBOutlet weak var widthMiniPlayer: NSLayoutConstraint!
    
    @IBOutlet weak var nameSong: UILabel!
    
    @IBOutlet weak var nameSing: UILabel!
    
    @IBOutlet weak var outletAddFavorite: UIButton!
    
    @IBOutlet weak var viewRight: UIView!
    
    @IBOutlet weak var outletPlayBtn: UIButton!
    
    @IBOutlet weak var outletRepeatBtn: UIButton!
    
    @IBOutlet weak var outletShufeBtn: UIButton!
    
    @IBOutlet weak var playerContainer: UIView!
    
    @IBOutlet weak var playerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var playerMiniHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imgSong: UIImageView!
    
    @IBOutlet weak var songMiniPlayer: UILabel!
    
    @IBOutlet weak var SingerMiniPlayer: UILabel!
    
    @IBOutlet weak var viewPlayer: UIView!
    
    @IBOutlet weak var miniPlayer: UIView!
    
    @IBOutlet weak var outletPlayMini: UIButton!
    
    
    var viewControllerHeight : CGRect?
    var youtubePlay = true
    var listSongs : [SongModel] = []
    var listSongFavorites: [SongModel] = []
    var index = 0
    var typePlayer = false
    
    var panGesture = UIPanGestureRecognizer()
    static let notificationName = Notification.Name("PlayerNotification")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerVC.playForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerDidFinishPlaying),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openPlayer(notification:)),
                                               name: PlayerVC.notificationName, object: nil)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView))
        miniPlayer.isUserInteractionEnabled = true
        miniPlayer.addGestureRecognizer(panGesture)
        
        configUI()
        configPlayer()
        setupPlayer()
        getFavorite(self.listSongs[index].id ?? "0")
        showPlayer()
    }
    
    @objc func openPlayer(notification:Notification){
        let data = notification.userInfo
        let _listSongs = data?["listSongs"] as? [SongModel]
        let _index = data?["indexPath"] as? Int
        
        if _listSongs == self.listSongs{
            if _index != self.index{
                self.index = _index ?? self.index
                self.resetPlayer()
                if let youtubeId = self.listSongs[index].youtubeId{
                    getStreamingLink(youtubeId, .play)
                }
                getFavorite(self.listSongs[index].id ?? "0")
            }
        }else{
            self.listSongs = _listSongs ?? self.listSongs
            self.index = _index ?? self.index
            self.resetPlayer()
            if let youtubeId = self.listSongs[index].youtubeId{
                getStreamingLink(youtubeId, .play)
            }
            getFavorite(self.listSongs[index].id ?? "0")
        }
    }
    
    func showPlayer(){
        self.playerMiniHeight.constant = 0
        self.miniPlayer.alpha = 0
    }
    
    @objc func playForeground(){
        AVPlayerViewControllerManager.shared.reconnectPlayer(rootViewController: self)
    }
    
    @objc func playerDidFinishPlaying(){
        AVPlayerViewControllerManager.shared.player?.pause()
        if typePlayer == false{
            self.index += 1
            self.resetPlayer()
        }
        
        if let youtubeId = self.listSongs[index].youtubeId{
            
            getStreamingLink(youtubeId, .playAndAdd)
        }
        getFavorite(self.listSongs[index].id ?? "0")
        
    }
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    var viewTranslationY: CGFloat = 120
    var viewTranslationX: CGFloat = 60
    var _viewTranslationX: CGFloat = 60
    
    
    @objc func draggedView(sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(miniPlayer)
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: self.view)
            if viewTranslation.x < -10{
                self.viewTranslationX = 60
            }else if viewTranslation.x > 10{
                self.viewTranslationX = self.view.bounds.width - 56
            }
            
            self.viewTranslationY += self.viewTranslation.y
            self._viewTranslationX += viewTranslation.x
            
            if self._viewTranslationX < 60{
                self._viewTranslationX = 60
            }
            if self.viewTranslationY < 40{
                self.viewTranslationY = 40
            }
            if self.viewTranslationY > UIScreen.main.bounds.height - 80{
                self.viewTranslationY = UIScreen.main.bounds.height - 80
            }
            self.view.frame = CGRect(x: self._viewTranslationX, y: self.viewTranslationY, width: self.view.bounds.width, height: 54)
            
            sender.setTranslation(CGPoint.zero, in: self.view)
        case .ended, .cancelled, .failed:
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.frame = CGRect(x: self.viewTranslationX, y: self.viewTranslationY, width: self.view.bounds.width, height: 54)
            })
            
            self._viewTranslationX = self.viewTranslationX
        default:
            break
        }
        
    }
    
    
    func setupPlayer(){
        let playerViewController = AVPlayerViewControllerManager.shared.controller
        playerViewController.view.frame = playerContainer.bounds
        addChild(playerViewController)
        playerContainer.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: self)
        
    }
    
    func configPlayer() {
        
        if let youtubeId = self.listSongs[index].youtubeId{
            getStreamingLink(youtubeId, .playAndAdd)
        }
    }
    
    func configUI() {
        self.imgSong.layer.cornerRadius = 27
        self.miniPlayer.layer.cornerRadius = 27
        self.viewRight.layer.cornerRadius = 13
        self.viewTranslationX = self.view.bounds.width - 56
        self.viewTranslationY = UIScreen.main.bounds.height - 80
        self.widthMiniPlayer.constant = UIScreen.main.bounds.width
        self.resetPlayer()
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
    
    
    func getStreamingLink(_ link: String, _ action:ActionType){
        self.showLoadingIndicator()
        
        XCDYouTubeClient.default().getVideoWithIdentifier(link) {(video, error ) in
            self.hideLoadingIndicator()
            
            if let er = error {
                
                let alertVC = UIAlertController(title: "Error", message: er.localizedDescription, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertVC.addAction(cancelAction)
                self.present(alertVC, animated: true, completion: nil)
            } else if let video = video {
                
                if action == .play || action == .playAndAdd{
                    
                    AVPlayerViewControllerManager.shared.video = video
                    
                    AVPlayerViewControllerManager.shared.player?.play()
                    
                }
            }
        }
    }
    
//    ic_pause_Black
    @IBAction func showMainPlayer(_ sender: Any) {
        
        self.viewPlayer.isHidden = false
        self.playerHeight.constant = self.view.bounds.height
        self.view.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height)
        self.miniPlayer.alpha = 0
        self.playerHeight.constant = self.view.bounds.height
        UIView.animate(withDuration: 1, animations: {
            self.view.frame = UIScreen.main.bounds
            self.viewPlayer.alpha = 1
        }) { (true) in
            self.playerMiniHeight.constant = 0
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
    func resetPlayer() {
        self.nameSing.text = self.listSongs[index].artist
        self.nameSong.text = self.listSongs[index].title
        
        if let strUrl = self.listSongs[index].thumbnail {
            let url = URL(string:strUrl)
            self.imgSong.kf.setImage(with: url)
        }else{
            self.imgSong.image = UIImage(named: "image_thumb")
        }
        self.SingerMiniPlayer.text = self.listSongs[index].artist
        self.songMiniPlayer.text = self.listSongs[index].title
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
    
    @IBAction func actionAlarmClock(_ sender: Any) {
        self.showToastAtBottom(message: "Coming soon")
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
            self.outletPlayMini.setImage(UIImage(named: "ic_pause_Black"), for: .normal)
            AVPlayerViewControllerManager.shared.player?.pause()
            self.youtubePlay = false
        }else{
            self.outletPlayBtn.setImage(UIImage(named: "ic_play"), for: .normal)
            self.outletPlayMini.setImage(UIImage(named: "ic_playerMini"), for: .normal)
            AVPlayerViewControllerManager.shared.player?.play()
            self.youtubePlay = true
        }
        
    }
    
    @IBAction func actionNext(_ sender: Any) {
        AVPlayerViewControllerManager.shared.player?.pause()
        AVPlayerViewControllerManager.shared.video = nil
        if index == self.listSongs.count - 1{
            self.popViewController()
        }else{
            self.index += 1
            self.resetPlayer()
            if let youtubeId = self.listSongs[index].youtubeId{
                getStreamingLink(youtubeId, .play)
            }
            getFavorite(self.listSongs[index].id ?? "0")
        }
    }
    
    @IBAction func actionPrev(_ sender: Any) {
        AVPlayerViewControllerManager.shared.player?.pause()
        AVPlayerViewControllerManager.shared.video = nil
        if index == 0{
            self.popViewController()
        }else{
            self.index -= 1
            self.resetPlayer()
            if let youtubeId = self.listSongs[index].youtubeId{
                getStreamingLink(youtubeId, .play)
            }
            getFavorite(self.listSongs[index].id ?? "0")
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.viewTranslationX = self.view.bounds.width
        UIView.animate(withDuration: 1, animations: {
            self.viewPlayer.alpha = 0
            self.view.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height)
            self.playerMiniHeight.constant = 54
        }) { (true) in
            self.view.frame = CGRect(x: self.viewTranslationX, y: self.viewTranslationY, width: self.view.bounds.width, height: 54)
            
            self.viewTranslationX = 60
            
            UIView.animate(withDuration: 1, animations: {
                self.view.frame = CGRect(x: self.viewTranslationX, y: self.viewTranslationY, width: self.view.bounds.width, height: 54)
            })
            self.miniPlayer.alpha = 1
            self.viewPlayer.isHidden = true
            self.playerHeight.constant = 0
        }
    }
    
    
    
}
