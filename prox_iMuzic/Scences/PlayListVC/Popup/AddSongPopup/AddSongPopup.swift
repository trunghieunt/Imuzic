//
//  AddSongPopup.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/14/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit
import FittedSheets


class AddSongPopup: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var listPlayList : [PlayListLocalModels] = []
    var songItem: SongModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        configTB()
        loadData()
    }
    func loadData() {
        StoragePlayList.sharedInstance.loadPlayList(success: { (listPlayList) in
            self.listPlayList = listPlayList
            self.tableview.reloadData()
            
        })
    }
    
    func configTB() {
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.registerCell(PlayListCell.className)
        self.tableview.separatorStyle = .none
    }

    @IBAction func addPlayList(_ sender: Any) {
        let vc = AddPlayListPopup.loadFromNib()
        vc.listPlayList = self.listPlayList
        vc.reload = {[weak self](listPlayList)in
            self?.listPlayList = listPlayList
            self?.tableview.reloadData()
        }
        guard let topVC = UIApplication.topViewController() else {
             return
         }
        let sheetController = SheetViewController(controller: vc,sizes: [.fullScreen])
        sheetController.topCornersRadius = 15
        
        topVC.present(sheetController, animated: false, completion: nil)
    }
    


}
extension AddSongPopup:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listPlayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayListCell.className, for: indexPath) as! PlayListCell
        cell.configCell(item: self.listPlayList[indexPath.row])
        cell.configCellPP()
        return cell
    }

    
}

extension AddSongPopup: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let songItem = self.songItem{
            let results = self.listPlayList[indexPath.row].songModel?.filter{$0.id == songItem.id}
            if results?.isEmpty == true{
                self.listPlayList[indexPath.row].songModel?.append(songItem)
                
                self.listPlayList[indexPath.row].songNumber = String(self.listPlayList[indexPath.row].songModel?.count ?? 0)
                
                
                self.listPlayList[indexPath.row].imageUrl = songItem.thumbnail
                
                
                
                
                StoragePlayList.sharedInstance.savePlayList(listFavorites: self.listPlayList)
                
                
                
                self.showToastAtBottom(message: "Success!!!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                    self.dismiss(animated: true, completion: nil)
                })
                
            }else{

                self.showToastAtBottom(message: "Song already exists in ' " +  (self.listPlayList[indexPath.row].title ?? "PlayList") + "'")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                     self.dismiss(animated: true, completion: nil)
                 })
            }
           
        }
    }
}
