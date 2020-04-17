//
//  GendersVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/9/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit


class GendersVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var listGenrens: [GenresModels] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    func configUI() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView.collectionViewLayout = layout
        
        self.collectionView.registerCell(GenderColl.className)
        
    }

    @IBAction func actionPopView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension GendersVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listGenrens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenderColl.className, for: indexPath) as! GenderColl
        cell.configCell(name: self.listGenrens[indexPath.row].name)
        cell.layer.cornerRadius = 35
        collectionView.setNeedsLayout()
        return cell
    }
    

}



extension GendersVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let vc = PlayListDetailVC.loadFromNib()
        vc.playlist = self.listGenrens[indexPath.row]
        vc.id = self.listGenrens[indexPath.row].id ?? "1"
        vc.type = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension GendersVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = self.listGenrens[indexPath.item].name
        label.sizeToFit()
        return CGSize(width: label.bounds.width + 93, height: 61)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 15
//    }

}
