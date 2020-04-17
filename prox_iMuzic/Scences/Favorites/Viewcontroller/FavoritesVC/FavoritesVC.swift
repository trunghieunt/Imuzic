//
//  FavoritesVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class FavoritesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

    
    var listSongs: [SongModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configTB()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getFavorite()
    }
    
    func configTB() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerCell(SongItemsCell.className)
        self.tableView.separatorStyle = .none
        self.tableView.emptyDataSetSource = self
        if #available(iOS 11.0, *) {

        }else{
            let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets(
                top: 0, left: 0,
                bottom: self.tabBarController!.tabBar.frame.height + 40, right: 0)
             self.tableView.contentInset = adjustForTabbarInsets
             self.tableView.scrollIndicatorInsets = adjustForTabbarInsets
        }
    }
    
    func getFavorite() {
        StoragePlayList.sharedInstance.loadFavorites { (listSongs) in
            self.listSongs = listSongs
            self.tableView.reloadData()
        }
    }
}

extension FavoritesVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongItemsCell.className, for: indexPath) as! SongItemsCell
        cell.configCell(listSong: self.listSongs[indexPath.row], favorite: true)
        cell.reload = {[weak self] in
            self?.listSongs.remove(at: indexPath.row)
            self?.tableView.reloadData()
        }
        return cell
    }
}

extension FavoritesVC: EmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "image_noplaylist")
    }
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let title = "No Favorite"
        let titleColor = [ NSAttributedString.Key.foregroundColor: UIColor.init("#686F79"), NSAttributedString.Key.font: AppFonts.coreSansGS55Medium(17)]
        let titleAttrString = NSAttributedString(string: title, attributes: titleColor)
        return titleAttrString
    }
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 25
    }
}


extension FavoritesVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlayerVC.loadFromNib()
        vc.listSongs = self.listSongs
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}
