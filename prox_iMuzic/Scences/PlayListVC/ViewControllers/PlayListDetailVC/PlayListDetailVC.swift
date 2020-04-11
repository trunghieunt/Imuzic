//
//  PlayListDetailVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/11/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import ViewAnimator
import PullToRefreshKit

class PlayListDetailVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var playList: PlayListModels?
    private var page = 1
    
    var listSongs: [SongModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getListSong(false)
    }
    
    func getListSong(_ loadmore: Bool) {
        
        if loadmore{
            self.page += 1
        }else{
            self.page = 1
            self.showLoadingIndicator()
        }
        
        
        ImuzicAPIManager.sharedInstance.getListSongs(subCateId: self.playList?.cateId ?? "1", limit: "20", success: { [weak self](listSongs, totalSongs) in
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
        self.tableView.registerCell(BannerDetailPLCell.className)
        self.tableView.registerCell(SongItemsCell.className)
        self.tableView.separatorStyle = .none
        tableView.allowsSelection = false

        self.tableView.reloadData()
        
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
            cellBanner.configCell(playList: self.playList!)
            return cellBanner
        }else{
            let cellItems = tableView.dequeueReusableCell(withIdentifier: SongItemsCell.className, for: indexPath) as! SongItemsCell
            cellItems.configCell(listSong: self.listSongs[indexPath.row - 1])
            return cellItems
        }

    }
    
    
}
