//
//  File.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/14/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class StoragePlayList: NSObject {
    
    
let userDefaults = UserDefaults.standard
    
    let STORAGE_PLAY_LIST = "playlist"
    let STORAGE_FAVORITES = "favorites"
    
    override init() {
        super.init()
    }
    
    class var sharedInstance: StoragePlayList {
        struct Static {
            static let instance: StoragePlayList = StoragePlayList()
        }
        return Static.instance
    }
    
    func savePlayList(listFavorites: [PlayListLocalModels]){
        let favoritesData = NSKeyedArchiver.archivedData(withRootObject: listFavorites)
        
        userDefaults.set(favoritesData, forKey: self.STORAGE_PLAY_LIST)
    }
    
    func loadPlayList(success :  @escaping ([PlayListLocalModels]) -> Void){
        guard let favoritesData = UserDefaults.standard.object(forKey: self.STORAGE_PLAY_LIST) as? NSData else {
            print("No favorite data")
            return
        }

        guard let favoritesArray = NSKeyedUnarchiver.unarchiveObject(with: favoritesData as Data) as? [PlayListLocalModels] else {
            print("Could not unarchive from placesData")
            return
        }

        success(favoritesArray)
    }
    
    func saveFavorites(listFavorites: [SongModel]){
        let favoritesData = NSKeyedArchiver.archivedData(withRootObject: listFavorites)
        
        userDefaults.set(favoritesData, forKey: self.STORAGE_FAVORITES)
    }
    
    func loadFavorites(success :  @escaping ([SongModel]) -> Void){
        guard let favoritesData = UserDefaults.standard.object(forKey: self.STORAGE_FAVORITES) as? NSData else {
            success([])
            print("No favorite data")
            return
        }

        guard let favoritesArray = NSKeyedUnarchiver.unarchiveObject(with: favoritesData as Data) as? [SongModel] else {
            print("Could not unarchive from placesData")
            success([])
            return
        }

        success(favoritesArray)
    }
}
