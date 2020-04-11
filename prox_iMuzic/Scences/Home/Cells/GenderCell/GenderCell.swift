//
//  GenderCell.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class GenderCell: UITableViewCell {
    
    @IBOutlet weak var collectionview: UICollectionView!
    var listGenrens : [GenresModels] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
        self.collectionview.registerCell(GenderColl.className)
        getAllGenren()
    }
    
    func getAllGenren() {
        ImuzicAPIManager.sharedInstance.getAllGenren(success: { [weak self] (listGenrens) in
            guard let sSelf = self else {return}
            sSelf.listGenrens = listGenrens
            sSelf.collectionview.reloadData()
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
    
    @IBAction func actionMove(_ sender: Any) {
        
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        let vc = GendersVC.loadFromNib()
        vc.listGenrens = self.listGenrens
        
        topVC.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension GenderCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listGenrens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenderColl.className, for: indexPath) as! GenderColl
        cell.configCell(name: self.listGenrens[indexPath.row].name)
        cell.setNeedsLayout()
        return cell
    }
    

}

extension GenderCell: UICollectionViewDelegate{

}

extension GenderCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = self.listGenrens[indexPath.item].name
        label.sizeToFit()
        return CGSize(width: label.bounds.width + 93, height: 69)
    }
}
