//
//  MainListVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import PinterestLayout

class MainListVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var cateType : CateType?
    var listPlayList : [PlayListModels] = []
    private var isShowRate = false
    private var timeShowRate = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configColl()
        getListPlaylist()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    func getListPlaylist() {
        if timeShowRate % 3 == 0{
            self.showAskRateApp()
        }
        
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        topVC.showLoadingIndicator()
        ImuzicAPIManager.sharedInstance.getListPlaylist(cateID: self.cateType?.id! ?? "1", limit: "5", offset: "0", success: { [weak self](listPlayList) in
            guard let sSelf = self else {return}
            sSelf.listPlayList = listPlayList
            sSelf.collectionView.reloadData()
            topVC.hideLoadingIndicator()
        }) { (error) in
            print(error)
            topVC.hideLoadingIndicator()
            topVC.showToastAtBottom(message: error)
        }
    }
    
    func showAskRateApp(){
        timeShowRate += 1
        if isShowRate {
            return
        }
        isShowRate = true
        #if !targetEnvironment(simulator)
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
        #endif
        
    }
    
    func configColl() {
        
        let layout = PinterestLayout()
        collectionView.collectionViewLayout = layout
        
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 2
        
//       self.collectionView.emptyDataSetSource = self
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.isScrollEnabled = false
        self.collectionView.registerCell(ListCollCell.className)
    }
    
}


extension MainListVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.listPlayList.count != 0{
            return 5
        }
        return self.listPlayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollCell.className, for: indexPath) as! ListCollCell
        if indexPath.row == 3{
            cell.configCellMore(item: self.listPlayList[indexPath.row])
            
        }else{
            cell.configCell(item: self.listPlayList[indexPath.row])
        }
        
        return cell
    }
    
    
}
extension MainListVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        if indexPath.row == 3{
            let vc = PlayListColVC.loadFromNib()
            vc.typeCate = self.cateType
            topVC.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = PlayListDetailVC.loadFromNib()
            vc.type = 0
            vc.playList = self.listPlayList[indexPath.row]
            vc.id = self.listPlayList[indexPath.row].playlistId ?? "1"
            topVC.navigationController?.pushViewController(vc, animated: true)
        }


    }
}

extension MainListVC: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 131
        case 1:
            return 175
        case 2:
            return 131
        case 3:
            return 240
        case 4:
            return 131
            
        default:
            return withWidth
        }
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        let textFont = UIFont(name: "Arial-ItalicMT", size: 11)!
        return "Some text".heightForWidth(width: withWidth, font: textFont)
    }
    
    
}

