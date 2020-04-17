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
    case getListPlaylist(cateID: String, limit: String, offset: String)
    case getAllGenres
    case getAllSongs(subCateId: String, limit: String, offset: String)
    case getListFree(offset: String)
    case getSearch(q: String, limit: String)
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
        case .getListFree:
            return URL.init(string: "http://mapgo2animez.ga/api/imuzic/getListFree")!
        case .getSearch(_):
            return URL.init(string: "http://mapgo2animez.ga/api/imuzic/search")!
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
        case .getListFree(_):
            return ""
        case .getSearch(_):
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
        case .getListPlaylist(let cateID, let limit, let offset):
            param["cateId"] = cateID
            param["limit"] = limit
            param["offset"] = offset
            let token = "http://mapgo2animez.ga/api/imuzic/getListPlaylist?cateId=\(cateID)&limit=\(limit)&offset=\(offset)".hmac(algorithm: .SHA256, key: "movietrailerhd.fun")
            param["token"] = token
            
        case .getAllGenres:
            break
        case .getAllSongs(let subCateId, let limit, let offset):
            param["subCateId"] = subCateId
            param["limit"] = limit
            param["offset"] = offset
            let token = "http://mapgo2animez.ga/api/imuzic/getListVideo?limit=\(limit)&offset=\(offset)&subCateId=\(subCateId)".hmac(algorithm: .SHA256, key: "movietrailerhd.fun")
            param["token"] = token
        case .getListFree(let offset):
            param["limit"] = 20
            param["offset"] = offset
            let token = "http://mapgo2animez.ga/api/imuzic/getListFree?limit=20&offset=\(offset)".hmac(algorithm: .SHA256, key: "movietrailerhd.fun")
            param["token"] = token
        case .getSearch(let q, let limit):
            param["q"] = q
            param["limit"] = limit
            param["offset"] = 0
            let token = "http://mapgo2animez.ga/api/imuzic/search?limit=\(limit)&offset=0&q=\(q)".hmac(algorithm: .SHA256, key: "movietrailerhd.fun")
            param["token"] = token
        }
        
        
        return .requestParameters(parameters: param, encoding: URLEncoding.default)
    }
    
    var headers: [String: String]? {
        return nil
    }
}


