//
//  File.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/8/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation
import Alamofire
import Moya


enum ImuzicServices {
    case getAllcate
    case getListPlaylist(cateID: String, limit: String)
    case getAllGenres
    case getAllSongs(subCateId: String, limit: String)
}

extension ImuzicServices: TargetType {
    
    var baseURL: URL {

        switch self {
        case .getAllcate:
            return URL.init(string: "http://mapgo2animez.ga/api/imuzic/getAllcate")!
        case .getListPlaylist:
            return URL.init(string:"http://mapgo2animez.ga/api/imuzic/getListPlaylist")!
        case .getAllGenres:
            return URL.init(string:"http://mapgo2animez.ga/api/imuzic/getListGenres")!
        case .getAllSongs(_):
            return URL.init(string: "http://mapgo2animez.ga/api/imuzic/getListVideo")!
        }
        
    }
    
    var path: String {
        switch self {
        case .getAllcate:
            return ""
        case .getListPlaylist(_):
            return ""
        case .getAllGenres:
            return ""
        case .getAllSongs(_):
            return ""
        }

    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Moya.Data {
        return Moya.Data.init()
    }
    
    var task: Task {
        
        var param = Parameters()
        
        switch self {
        case .getAllcate:
            break
        case .getListPlaylist(let cateID, let limit):
            param["cateId"] = cateID
            param["limit"] = limit
            param["offset"] = 0
            let token = "http://mapgo2animez.ga/api/imuzic/getListPlaylist?cateId=\(cateID)&limit=\(limit)&offset=0".hmac(algorithm: .SHA256, key: "movietrailerhd.fun")
            param["token"] = token
            
        case .getAllGenres:
            break
        case .getAllSongs(let subCateId, let limit):
            param["subCateId"] = subCateId
            param["limit"] = limit
            param["offset"] = 0
            let token = "http://mapgo2animez.ga/api/imuzic/getListVideo?limit=\(limit)&offset=0&subCateId=\(subCateId)".hmac(algorithm: .SHA256, key: "movietrailerhd.fun")
            param["token"] = token
        }
        
        
        return .requestParameters(parameters: param, encoding: URLEncoding.default)
    }
    
    var headers: [String: String]? {
        return nil
    }
}


