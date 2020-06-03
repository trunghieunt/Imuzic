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
                    let vc = PlayerVC.loadFromNib()
                    vc.listSongs = self!.listSongs
                    
                    if isPlay{
                        vc.index = 0
                    }else{
                        vc.index = Int.random(in: 0 ... (self?.listSongs.count)!)
                    }
                    self?.navigationController?.present( vc, animated: true, completion: nil)
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
                secondViewController?.add()
            }else{
                check = true
                if #available(iOS 11.0, *) {
                    controller.viewControllerHeight = self.view.bounds
                    controller.view.frame = CGRect(x: 0, y: self.view.bounds.height - 100, width: self.view.bounds.width, height: 50)
                } else {
                    // Fallback on earlier versions
                }
                
                window.addSubview(controller.view)
                
                self.secondViewController = controller
            }
        }
        
    }
}


var check = false
