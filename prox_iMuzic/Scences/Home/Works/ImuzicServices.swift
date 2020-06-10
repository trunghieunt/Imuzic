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

let API_KEY = "AIzaSyBPO8E9UuOB3APiw2w1ShsFP7OI5rfzRBU"

enum ImuzicServices {
    case getAllcate
    case getListPlaylist(cateID: String, limit: String, offset: String)
    case getAllGenres
    case getAllSongs(subCateId: String, limit: String, offset: String)
    case getListFree(pageToken: String, q: String)
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
        case .getAllSongs(let subCateId, _, _):
            if subCateId.isNumber{
                return URL.init(string: "http://mapgo2animez.ga/api/imuzic/getListVideo")!
            }else{
                return URL.init(string: "http://mapgo2animez.ga/api/imuzic/getListVideoWithPlaylistId")!
            }
        case .getListFree:
            return URL.init(string: "https://www.googleapis.com/youtube/v3/search")!
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
            if subCateId.isNumber{
                param["subCateId"] = subCateId
                param["limit"] = limit
                param["offset"] = offset
                let token = "http://mapgo2animez.ga/api/imuzic/getListVideo?limit=\(limit)&offset=\(offset)&subCateId=\(subCateId)".hmac(algorithm: .SHA256, key: "movietrailerhd.fun")
                param["token"] = token
            }else{
                param["playlistId"] = subCateId.toBase64()
                param["limit"] = limit
                param["offset"] = offset
                let token = "http://mapgo2animez.ga/api/imuzic/getListVideoWithPlaylistId?limit=\(limit)&offset=\(offset)&playlistId=\(subCateId.toBase64().replace("=", with: "%3D"))".hmac(algorithm: .SHA256, key: "movietrailerhd.fun")
                param["token"] = token
            }
            
        case .getListFree(let pageToken, let q):
            param["part"] = "snippet"
            param["type"] = "video"
            param["maxResults"] = 20
            param["pageToken"] = pageToken
            param["key"] = API_KEY
            param["q"] = q
        }
        
        
        return .requestParameters(parameters: param, encoding: URLEncoding.default)
    }
    
    var headers: [String: String]? {
        return nil
    }
}


extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }
    
    
    func replace(_ originalString:String, with newString:String) -> String {
        return self.replacingOccurrences(of: originalString, with: newString)
    }
    
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

}
