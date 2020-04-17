//
//  AddPlayListPopup.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/10/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import UIKit


class AddPlayListPopup: UIViewController{
    @IBOutlet weak var outletOK: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    var reload: ([PlayListLocalModels])->() = {_ in}
    
    var listPlayList : [PlayListLocalModels] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.returnKeyType = UIReturnKeyType.done
        outletOK.roundCorners(.allCorners, radius: 25)
    }



    @IBAction func actionOK(_ sender: Any) {
        if let nameList = self.textField.text{
            let listPlayer = PlayListLocalModels.init(title: nameList, imageUrl: "", songNumber: "0", songModel: [])
            self.listPlayList.append(listPlayer)
            StoragePlayList.sharedInstance.savePlayList(listFavorites: self.listPlayList)
            self.reload(self.listPlayList)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
   
}
