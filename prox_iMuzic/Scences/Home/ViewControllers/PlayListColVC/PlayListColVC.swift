//
//  PlayListColVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/14/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import PinterestLayout

class PlayListColVC: UIViewController {
    @IBOutlet weak var titleView: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var typeCate: CateType?
    var listPlayList : [PlayListModels] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configColl()
    }
    func configColl() {
        self.titleView.text = typeCate?.title
        
        let layout = PinterestLayout()
        collectionView.collectionViewLayout = layout
        
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 2
        
        //       self.collectionView.emptyDataSetSource = self
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        getListPlaylist()
        self.collectionView.registerCell(ListCollCell.className)
    }
    
    func getListPlaylist(){
        self.showLoadingIndicator()
        ImuzicAPIManager.sharedInstance.getListPlaylist(cateID: self.typeCate?.id! ?? "1", limit: "20", offset: "0", success: { [weak self](listPlayList) in
            guard let sSelf = self else {return}
            sSelf.listPlayList = listPlayList
            sSelf.collectionView.reloadData()
            sSelf.hideLoadingIndicator()
        }) { (error) in
            print(error)
            self.hideLoadingIndicator()
            self.showToastAtBottom(message: error)
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.popViewController()
    }
    
    
    
}

extension PlayListColVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listPlayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollCell.className, for: indexPath) as! ListCollCell
        cell.configCell(item: self.listPlayList[indexPath.row])
        
        return cell
    }
    
    
}
extension PlayListColVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        let vc = PlayListDetailVC.loadFromNib()
        vc.playList = self.listPlayList[indexPath.row]
        vc.id = self.listPlayList[indexPath.row].playlistId ?? "1"
        vc.type = 0
        topVC.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PlayListColVC: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        let heights : [CGFloat] = [131,175,240,150,200]
        return heights.randomElement()!
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        let textFont = UIFont(name: "Arial-ItalicMT", size: 11)!
        return "Some text".heightForWidth(width: withWidth, font: textFont)
    }
    
    
}

