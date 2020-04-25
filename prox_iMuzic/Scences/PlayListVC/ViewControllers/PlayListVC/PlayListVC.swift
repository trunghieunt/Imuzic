//
//  PlayListVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/7/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import FSPagerView
import EmptyDataSet_Swift
import FittedSheets

class PlayListVC: UIViewController {
    
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    @IBOutlet weak var PagerView: FSPagerView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var outletAdd: UIButton!
    
    
    
    var listPlayList : [PlayListLocalModels] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configFSView()
        configTB()
        self.typeView(checkType: 1)
        checkData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    
    func loadData() {
        StoragePlayList.sharedInstance.loadPlayList(success: { (listPlayList) in
            self.listPlayList = listPlayList
            self.checkData()
            self.tableView.reloadData()
        })
    }
    
    func checkData() {
        if self.listPlayList.count == 0{
            self.typeView(checkType: 1)
            self.outletAdd.isHidden = true
            self.segmentView.isHidden = true
            self.segmentView.isEnabledForSegment(at: 0)
        }else{
            self.outletAdd.isHidden = false
            self.segmentView.isHidden = false
        }
    }

    func configTB() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.registerCell(PlayListCell.className)
        if #available(iOS 11.0, *) {

        }else{
            let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets(
                top: 0, left: 0,
                bottom: self.tabBarController!.tabBar.frame.height + 40, right: 0)
             self.tableView.contentInset = adjustForTabbarInsets
             self.tableView.scrollIndicatorInsets = adjustForTabbarInsets
        }
    }

    func configFSView() {
        self.PagerView.register(UINib(nibName: PlayListFSCell.className, bundle: nil), forCellWithReuseIdentifier: PlayListFSCell.className)
        PagerView.delegate = self
        PagerView.dataSource = self
        
        PagerView.isInfinite = true
        
        PagerView.transformer = FSPagerViewTransformer(type: .zoomOut)
        
    }
    
    func typeView(checkType: Int) {
        if checkType == 0{
            
            UIView.animate(withDuration: 0.6) {
                self.PagerView.layer.opacity = 1
            }
            self.tableView.isHidden = true
            self.tableView.layer.opacity = 0
            self.PagerView.isHidden = false
            
            
        }else{
            UIView.animate(withDuration: 0.9) {
                self.tableView.layer.opacity = 1
            }
            self.tableView.isHidden = false
            self.PagerView.layer.opacity = 0
            self.PagerView.isHidden = true
            
        }
    }
    
    @IBAction func actionSegmentView(_ sender: UISegmentedControl) {
        for (index, view) in sender.subviews.enumerated() {
            if index == sender.selectedSegmentIndex {
                self.typeView(checkType: index)
            } else {
                
            }
        }
    }
    
    
    @IBAction func actionAddPlayList(_ sender: Any) {
        let vc = AddPlayListPopup.loadFromNib()
        vc.listPlayList = self.listPlayList
        vc.reload = {[weak self](listPlayList)in
            self?.listPlayList = listPlayList
            self?.tableView.reloadData()
            self?.PagerView.reloadData()
            self?.checkData()
        }
        let sheetController = SheetViewController(controller: vc,sizes: [.fullScreen,.fixed(self.view.bounds.width)])
        sheetController.topCornersRadius = 15
        
        self.present(sheetController, animated: false, completion: nil)
    }


}

extension PlayListVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPlayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayListCell.className, for: indexPath) as! PlayListCell
        cell.configCell(item: self.listPlayList[indexPath.row])
        cell.doneRemove = {[weak self] in
            self?.listPlayList.remove(at: indexPath.row)
            StoragePlayList.sharedInstance.savePlayList(listFavorites: self?.listPlayList ?? [])
            self?.checkData()
            self?.tableView.reloadData()
            self?.PagerView.reloadData()
        }
        return cell
    }
}


extension PlayListVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlayListDetailVC.loadFromNib()
        vc.listPlayer = self.listPlayList[indexPath.row]
        vc.type = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension PlayListVC: FSPagerViewDelegate{
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let vc = PlayListDetailVC.loadFromNib()
        vc.listPlayer = self.listPlayList[index]
        vc.type = 1
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}



extension PlayListVC: FSPagerViewDataSource{
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return listPlayList.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: PlayListFSCell.className, at: index) as! PlayListFSCell
        cell.configCell(item: self.listPlayList[index])
        cell.doneRemove = {[weak self] in
            self?.listPlayList.remove(at: index)
            StoragePlayList.sharedInstance.savePlayList(listFavorites: self?.listPlayList ?? [])
            self?.tableView.reloadData()
            self?.PagerView.reloadData()
            self?.checkData()
        }
        return cell
    }
}

extension PlayListVC: EmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "image_noplaylist")
    }
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let title = "No playlists"
        let titleColor = [ NSAttributedString.Key.foregroundColor: UIColor.init("#686F79"), NSAttributedString.Key.font: AppFonts.coreSansGS55Medium(17)]
        let titleAttrString = NSAttributedString(string: title, attributes: titleColor)
        
        return titleAttrString
    }
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 25
    }
}

extension PlayListVC: EmptyDataSetDelegate{
    func buttonImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        return UIImage(named: "createPlayList")
    }
    
    
    func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        let vc = AddPlayListPopup.loadFromNib()
        vc.listPlayList = self.listPlayList
        vc.reload = {[weak self](listPlayList)in
            self?.listPlayList = listPlayList
            self?.tableView.reloadData()
            self?.PagerView.reloadData()
            self?.checkData()
        }
        let sheetController = SheetViewController(controller: vc,sizes: [.fullScreen,.fixed(self.view.bounds.width)])
        sheetController.topCornersRadius = 15
        
        self.present(sheetController, animated: false, completion: nil)
    }
}
