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
    @IBOutlet weak var searchBar: UITextField!
    
    private var searchTimer:Timer?
    
    var textSearch : String = ""
    var listSongSearch: [SearchModels] = []
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTB()
        getListFree(loadmore: false)
        configRefresh()
        // Do any additional setup after loading the view.
    }
    func configTB() {
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.registerCell(PlayListCell.className)
        
        searchBar.attributedPlaceholder = NSAttributedString(string: "Enter anime tv shows title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        searchBar.layer.cornerRadius = 8
        searchBar.setLeftPaddingPoints(10)
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.delegate = self
        searchBar.addTarget(self, action: #selector(actionSearch), for: .editingChanged)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboards))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    @objc func dismissKeyboards() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
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
        self.textSearch = self.searchBar.text ?? ""
        if self.textSearch != ""{
            getlistItemsSearch(loadmore: false)
        }else{
            getListFree(loadmore: false)
        }
    }
    
    
    func getlistItemsSearch(loadmore: Bool) {
        if loadmore{
            self.page += 20
        }else{
            self.page = 0
            self.showLoadingIndicator()
        }
        
        ImuzicAPIManager.sharedInstance.getListSearch(q: self.textSearch, limit: "20", success: {[weak self](listSongSearch) in
            guard let sSelf = self else {return}
            if loadmore{
                sSelf.listSongSearch.append(contentsOf: listSongSearch)
            }else{
                sSelf.listSongSearch = listSongSearch
            }
            
            sSelf.hideLoadingIndicator()
            sSelf.tableView.reloadData()
            sSelf.tableView.switchRefreshFooter(to: .normal)
            sSelf.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
        }) { (error) in
            self.hideLoadingIndicator()
            self.showToastAtBottom(message: error)
        }
    }
    
    
    
    func getListFree(loadmore: Bool) {
        
        if loadmore{
            self.page += 20
        }else{
            self.page = 0
            self.showLoadingIndicator()
        }
        ImuzicAPIManager.sharedInstance.getListFree(offset: String(self.page), success: { [weak self](listSongSearch, count) in
            guard let sSelf = self else {return}
            if loadmore{
                sSelf.listSongSearch.append(contentsOf: listSongSearch)
            }else{
                sSelf.listSongSearch = listSongSearch
            }
            
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
            if self.textSearch != ""{
                self.getlistItemsSearch(loadmore: true)
            }else{
                self.getListFree(loadmore: true)
            }
        }
        

        self.tableView.configRefreshHeader(container: self) {
            if self.textSearch != ""{
                self.getlistItemsSearch(loadmore: false)
            }else{
                self.getListFree(loadmore: false)
            }
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
        let vc = PlayerVC.loadFromNib()
        self.present(vc, animated: true, completion: nil)
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
