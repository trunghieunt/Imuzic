//
//  PlayListDetailVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/11/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import PullToRefreshKit

class PlayListDetailVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var secondViewController : PlayerVC?
    
    var playlist: GenresModels?
    var playList: PlayListModels?
    
    private var page = 1
    
    var type = 0
    
    var id = "1"
    
    var listSongs: [SongModel] = []
    
    var listPlayer: PlayListLocalModels?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()

        if type == 0{
            configTB()
            getListSong(false)
        }else if type == 1{
            self.listSongs = self.listPlayer?.songModel ?? []
        }else{
            configTB()
            getListSong(false)
        }
    }

    
    func getListSong(_ loadmore: Bool) {
        
        if loadmore{
            self.page += 20
        }else{
            self.page = 0
            self.showLoadingIndicator()
        }
        
        
        ImuzicAPIManager.sharedInstance.getListSongs(subCateId: self.id, limit: "20", offset: String(self.page), success: { [weak self](listSongs, totalSongs) in
            guard let sSelf = self else {return}
            if loadmore{
                sSelf.listSongs.append(contentsOf: listSongs)
            }else{
                sSelf.listSongs = listSongs
            }
            
            sSelf.hideLoadingIndicator()
            sSelf.tableView.reloadData()
            sSelf.tableView.switchRefreshFooter(to: .normal)
            sSelf.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
        }) { [weak self] (error) in
            guard let sSelf = self else {return}
            sSelf.showToastAtBottom(message: error)
            sSelf.hideLoadingIndicator()
            sSelf.tableView.switchRefreshFooter(to: .normal)
            sSelf.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
        }
    }
    func configUI() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerCell(BannerDetailPLCell.className)
        self.tableView.registerCell(SongItemsCell.className)
        self.tableView.separatorStyle = .none
        
    }
    
    func configTB() {
        
        self.tableView.configRefreshFooter(container: self) {
            self.getListSong(true)
        }
        
        let header = DefaultRefreshHeader.header()
        header.setText("", mode: .pullToRefresh)
        self.tableView.configRefreshHeader(with: header, container: self) {
            self.getListSong(false)
        }
    }
    
}


extension PlayListDetailVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listSongs.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cellBanner = tableView.dequeueReusableCell(withIdentifier: BannerDetailPLCell.className, for: indexPath) as! BannerDetailPLCell
            if type == 0{
                cellBanner.configCell(playList: self.playList!)
            }else if type == 1{
                cellBanner.configCell(playList: self.listPlayer!)
            }else{
                cellBanner.configCell(playList: self.playlist!)
            }
            
            cellBanner.playerType = {[weak self](isPlay) in
                if self!.listSongs.count != 0{
                    let controller = PlayerVC.loadFromNib()
                    controller.listSongs = self!.listSongs
                    
                    let window = UIApplication.shared.keyWindow!
                    var index = 0
                    if isPlay{
                        index = 0
                    }else{
                        index = Int.random(in: 0 ... (self?.listSongs.count)!)
                    }
                    
                    if check{
                        let dataDict: [String: Any] = ["listSongs": self?.listSongs, "indexPath" : index]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PlayerNotification"), object: nil,userInfo: dataDict)
                    }else{
                        check = true
                        controller.index = index
                        controller.viewControllerHeight = self?.view.bounds
                        controller.view.frame = UIScreen.main.bounds
                        
                        window.addSubview(controller.view)
                        
                        controller.view.alpha = 0
                        controller.view.isHidden = true
                        
                        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve, animations: {
                            controller.view.isHidden = false
                            controller.view.alpha = 1
                        }, completion: nil)
                        
                        self?.secondViewController = controller
                    }
                    
                }else{
                    self?.showToastAtBottom(message: "No Songs")
                }
               
            }
            
            return cellBanner
        }else{
            let cellItems = tableView.dequeueReusableCell(withIdentifier: SongItemsCell.className, for: indexPath) as! SongItemsCell
            cellItems.configCell(listSong: self.listSongs[indexPath.row - 1])
            cellItems.selectionStyle = .none
            return cellItems
        }
        
    }
    
    
}

extension PlayListDetailVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            let controller = PlayerVC.loadFromNib()
            controller.listSongs = self.listSongs
            controller.index = indexPath.row - 1
            let window = UIApplication.shared.keyWindow!
            
            if check{
                let dataDict: [String: Any] = ["listSongs": self.listSongs, "indexPath" : indexPath.row - 1]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PlayerNotification"), object: nil,userInfo: dataDict)
            }else{
                check = true
                controller.viewControllerHeight = self.view.bounds
                controller.view.frame = UIScreen.main.bounds
                
                window.addSubview(controller.view)
                
                controller.view.alpha = 0
                controller.view.isHidden = true
                
                UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve, animations: {
                    controller.view.isHidden = false
                    controller.view.alpha = 1
                }, completion: nil)
                
                self.secondViewController = controller
            }
        }
        
    }
}


var check = false
