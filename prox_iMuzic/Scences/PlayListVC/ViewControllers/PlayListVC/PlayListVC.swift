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
import ViewAnimator

class PlayListVC: UIViewController {
    
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    @IBOutlet weak var PagerView: FSPagerView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var outletAdd: UIButton!
    
    
    
    var listPlayList = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configFSView()
        configTB()
        self.typeView(checkType: 1)
        checkData()
        
    }
    
    func checkData() {
        if self.listPlayList == 0{
            self.outletAdd.isHidden = true
            self.segmentView.isHidden = true
        }else{
            self.outletAdd.isHidden = false
            self.segmentView.isHidden = false
        }
    }

    func configTB() {
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.registerCell(PlayListCell.className)
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
        let sheetController = SheetViewController(controller: vc,sizes: [.fullScreen,.fixed(self.view.bounds.width)])
        sheetController.topCornersRadius = 15
        sheetController.view.frame.size.width = self.view.bounds.width
        self.present(sheetController, animated: false, completion: nil)
    }


}

extension PlayListVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPlayList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayListCell.className, for: indexPath) as! PlayListCell
        return cell
    }
    
    
}

extension PlayListVC: FSPagerViewDelegate{
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
}

extension PlayListVC: FSPagerViewDataSource{
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return listPlayList
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: PlayListFSCell.className, at: index) as! PlayListFSCell
//        cell.configCell(item: self.listPlayList[index])
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
    
    func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        let vc = AddPlayListPopup.loadFromNib()
        let sheetController = SheetViewController(controller: vc,sizes: [.fullScreen,.fixed(self.view.bounds.width)])
        sheetController.topCornersRadius = 15
        sheetController.view.frame.size.width = self.view.bounds.width
        self.present(sheetController, animated: false, completion: nil)
    }
}
