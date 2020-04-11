//
//  MenuCell.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import BmoViewPager

class MenuCell: UITableViewCell {

    @IBOutlet weak var BmoPager: BmoViewPager!
    
    @IBOutlet weak var BmoPagerNav: BmoViewPagerNavigationBar!
    
    var listCates: [CateType] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configTabStrip()
        getAllCate()
    }

    func configTabStrip() {
        BmoPager.dataSource = self
        BmoPagerNav.viewPager = BmoPager
        BmoPagerNav.isInterpolationAnimated = true
        
//        BmoPagerNav.layer.maskedCorners = true
        BmoPager.delegate = self
        
    }
    
    func getAllCate() {
        ImuzicAPIManager.sharedInstance.getAllCate(success: { [weak self] (listCates) in
            guard let sSelf = self else {return}
            sSelf.listCates = listCates
            sSelf.BmoPagerNav.reloadData()
            sSelf.BmoPager.reloadData()
           
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

extension MenuCell: BmoViewPagerDataSource{
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        return self.listCates.count
    }
    
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        let vc = MainListVC.loadFromNib()
        vc.cateType = self.listCates[page]
        return vc
    }
    func bmoViewPagerDataSourceNaviagtionBarItemSpace(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> CGFloat {
        return 5
    }
    
}
extension MenuCell: BmoViewPagerDelegate{
    func bmoViewPagerDataSourceNaviagtionBarItemTitle(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> String? {
        return self.listCates[page].title
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemNormalAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.foregroundColor : UIColor.lightGray,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0)
        ]
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14.0)
//            NSAttributedString.Key.
        ]
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedBackgroundView(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = AppColors.primary
        view.layer.cornerRadius = 14
  
//        view.bounds.height. = 30
        return view
    }
    

    func bmoViewPagerDataSourceNaviagtionBarItemSize(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> CGSize {
        let font = UIFont.boldSystemFont(ofSize: 14.0)
        var width = CGFloat()
        if self.listCates.count != 0{
            width = self.listCates[page].title!.widthFromHeight(height: navigationBar.bounds.height, font: font) + 12
            
        }
        
        return CGSize(width: width, height: navigationBar.bounds.height)
    }
}
