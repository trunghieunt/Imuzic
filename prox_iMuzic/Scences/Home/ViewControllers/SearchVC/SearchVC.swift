//
//  SearchVC.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/14/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UITextField!{
        didSet{
            self.searchBar.addRightImage("search")
        }
    }
    
    var secondViewController : PlayerVC?
    private var searchTimer:Timer?
    
    var textSearch : String = ""
    var listSongSearch: [SongModel] = []
    var nextPageToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTB()
        getListFree(loadmore: false)
        configRefresh()
        // Do any additional setup after loading the view.
    }
    func configTB() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.registerCell(PlayListCell.className)
        
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        searchBar.layer.cornerRadius = 8
        searchBar.setLeftPaddingPoints(10)
        searchBar.returnKeyType = UIReturnKeyType.search
        searchBar.delegate = self
        searchBar.addTarget(self, action: #selector(actionSearch), for: .editingChanged)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboards))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    @objc func dismissKeyboards() {
        view.endEditing(true)
    }
    
    @objc func actionSearch(){
        
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(timeInterval: 1,
                                           target: self,
                                           selector: #selector(updateSearch),
                                           userInfo: nil,
                                           repeats: false)
        
    }
    
    @objc func updateSearch(){
        getListFree(loadmore: false)
    }
    
    
    func getListFree(loadmore: Bool) {
        
        if loadmore{
            
        }else{
            self.nextPageToken = ""
            self.showLoadingIndicator()
        }
        ImuzicAPIManager.sharedInstance.getListFree(pageToken: self.nextPageToken, q: self.searchBar.text ?? "", success: { [weak self](listSongSearch, nextPageToken) in
            guard let sSelf = self else {return}
            if loadmore{
                sSelf.listSongSearch.append(contentsOf: listSongSearch)
            }else{
                sSelf.listSongSearch = listSongSearch
            }
            
            sSelf.nextPageToken = nextPageToken ?? ""
            
            sSelf.hideLoadingIndicator()
            sSelf.tableView.reloadData()
            sSelf.tableView.switchRefreshFooter(to: .normal)
            sSelf.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
        }) { (error) in
            self.hideLoadingIndicator()
            self.showToastAtBottom(message: error)
        }
    }
    
    func configRefresh() {
        
        self.tableView.configRefreshFooter(container: self) {
            self.getListFree(loadmore: true)
        }
        
        
        self.tableView.configRefreshHeader(container: self) {
            self.getListFree(loadmore: false)
        }
    }
    

    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SearchVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listSongSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayListCell.className, for: indexPath) as! PlayListCell
        cell.configCell(item: self.listSongSearch[indexPath.row])
        cell.outletbtn.isHidden = true
        return cell
    }
    
    
}

extension SearchVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = PlayerVC.loadFromNib()
        controller.listSongs = self.listSongSearch
        
        let window = UIApplication.shared.keyWindow!
        
        if check{
            let dataDict: [String: Any] = ["listSongs": self.listSongSearch, "indexPath" : indexPath.row]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PlayerNotification"), object: nil,userInfo: dataDict)
        }else{
            check = true
            controller.index = indexPath.row
            controller.viewControllerHeight = self.view.bounds
            controller.view.frame = UIScreen.main.bounds
            
            window.addSubview(controller.view)
            
            controller.view.alpha = 0
            controller.view.isHidden = true
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve, animations: {
                controller.view.isHidden = false
                controller.view.alpha = 1
            }, completion: nil)
            
            self.secondViewController = controller
        }
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
