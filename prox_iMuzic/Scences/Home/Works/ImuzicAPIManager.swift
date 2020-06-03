//
//  File.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON


struct ImuzicAPIManager {
    static let sharedInstance = ImuzicAPIManager()
    //    let myNetworkLoggerPlugin =
    let provider = MoyaProvider<ImuzicServices>(plugins: [NetworkLoggerPlugin(verbose: false)])
    
    
    func getAllCate(success :  @escaping ([CateType]) -> Void,failed :  @escaping (String) -> Void) {
        var listCate : [CateType] = []
        
        provider.request(.getAllcate) { (result) in
            switch result{
            case .success(let value):
                do {
                    let json = try JSON.init(data: value.data)
                    let results = json["Imuzic"]["Items"].arrayValue
                    
                    for result in results{
                        let cate = CateType.init(json: result)
                        listCate.append(cate)
                    }
                    success(listCate)
                } catch(let error) {
                    failed(error.localizedDescription)
                }
            case .failure(let error):
                failed(error.localizedDescription)
            }
        }
    }
    
    func getAllGenren(success :  @escaping ([GenresModels]) -> Void,failed :  @escaping (String) -> Void) {
        var listGenres : [GenresModels] = []
        
        provider.request(.getAllGenres) { (result) in
            switch result{
            case .success(let value):
                do {
                    let json = try JSON.init(data: value.data)
                    let results = json["Imuzic"]["Items"].arrayValue
                    
                    for result in results{
                        let genres = GenresModels.init(json: result)
                        listGenres.append(genres)
                    }
                    success(listGenres)
                } catch(let error) {
                    failed(error.localizedDescription)
                }
                
            case .failure(let error):
                failed(error.localizedDescription)
            }
        }
    }
    
    func getListPlaylist(cateID: String, limit: String,offset: String,success :  @escaping ([PlayListModels]) -> Void,failed :  @escaping (String) -> Void) {
        var itemsPlayList : [PlayListModels] = []
        
        provider.request(.getListPlaylist(cateID: cateID, limit: limit, offset: offset)) { (result) in
            switch result{
            case .success(let value):
                do {
                    let json = try JSON.init(data: value.data)
                    let results = json["Imuzic"]["Items"].arrayValue
                    
                    for result in results{
                        let playList = PlayListModels.init(json: result)
                        itemsPlayList.append(playList)
                    }
                    success(itemsPlayList)
                } catch(let error) {
                    failed(error.localizedDescription)
                }
            case .failure(let error):
                failed(error.localizedDescription)
            }
        }
    }
    
    func getListSongs(subCateId: String, limit: String, offset: String,success :  @escaping ([SongModel], Int?) -> Void,failed :  @escaping (String) -> Void) {
        var listSong : [SongModel] = []
        
        provider.request(.getAllSongs(subCateId: subCateId, limit: limit, offset: offset)) { (result) in
            switch result{
            case .success(let value):
                do {
                    let json = try JSON.init(data: value.data)
                    print(json)
                    let results = json["Imuzic"]["Items"].arrayValue
                    let countSong = json["Imuzic"]["TotalSongs"].int
                    for result in results{
                        let song = SongModel.init(json: result)
                        listSong.append(song)
                    }
                    success(listSong, countSong)
                } catch(let error) {
                    failed(error.localizedDescription)
                }
            case .failure(let error):
                failed(error.localizedDescription)
            }
        }
    }
    
    func getListFree(offset: String,success :  @escaping ([SearchModels], Int?) -> Void,failed :  @escaping (String) -> Void) {
        var listSong : [SearchModels] = []
        
        provider.request(.getListFree(offset: offset)) { (result) in
            switch result{
            case .success(let value):
                do {
                    let json = try JSON.init(data: value.data)
                    let results = json["Imuzic"]["Items"].arrayValue
                    let countSong = json["Imuzic"]["TotalSongs"].int
                    for result in results{
                        let song = SearchModels.init(json: result)
                        listSong.append(song)
                    }
                    success(listSong, countSong)
                } catch(let error) {
                    failed(error.localizedDescription)
                }
            case .failure(let error):
                failed(error.localizedDescription)
            }
        }
    }
    
    func getListSearch(q: String, limit: String,success :  @escaping ([SearchModels]) -> Void,failed :  @escaping (String) -> Void) {
        var listSong : [SearchModels] = []
        
        provider.request(.getSearch(q: q, limit: limit)) { (result) in
            switch result{
            case .success(let value):
                do {
                    let json = try JSON.init(data: value.data)
                    print(json)
                    let results = json["TrailerBox"].arrayValue
                    for result in results{
                        let song = SearchModels.init(json: result)
                        listSong.append(song)
                    }
                    success(listSong)
                } catch(let error) {
                    failed(error.localizedDescription)
                }
            case .failure(let error):
                failed(error.localizedDescription)
            }
        }
    }
}


