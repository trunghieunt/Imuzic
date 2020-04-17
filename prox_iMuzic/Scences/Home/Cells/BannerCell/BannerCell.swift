//
//  BannerCell.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import FSPagerView

class BannerCell: UITableViewCell {
    
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(UINib(nibName: ItemsBannerCell.className, bundle: nil), forCellWithReuseIdentifier: ItemsBannerCell.className)
        }
    }
    
    var listPlayList : [PlayListModels] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configFSView()
        getListPlaylist()
    }
    
    
    func configFSView()  {
        pagerView.delegate = self
        pagerView.dataSource = self
        
        pagerView.automaticSlidingInterval = 6
        pagerView.isInfinite = true
        
        pagerView.transformer = FSPagerViewTransformer(type: .zoomOut)
    }
    
    func getListPlaylist() {
        ImuzicAPIManager.sharedInstance.getListPlaylist(cateID: "1", limit: "5", offset: "0", success: { [weak self](listPlayList) in
            guard let sSelf = self else {return}
            sSelf.listPlayList = listPlayList
            sSelf.pagerView.reloadData()
        }) { (error) in
            print(error)
            guard let topVC = UIApplication.topViewController() else {
                return
            }
            topVC.showToastAtBottom(message: error)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension BannerCell: FSPagerViewDelegate{
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        let vc = PlayListDetailVC.loadFromNib()
        vc.playList = self.listPlayList[index]
        vc.id = self.listPlayList[index].id ?? "1"
        vc.type = 0
        topVC.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension BannerCell: FSPagerViewDataSource{
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.listPlayList.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: ItemsBannerCell.className, at: index) as! ItemsBannerCell
        cell.configCell(item: self.listPlayList[index])
        return cell
    }
}
