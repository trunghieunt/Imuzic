//
//  SongModel.swift
//
//  Created by Nguyen Trung Hieu on 4/11/20
//  Copyright (c) . All rights reserved.
//


import Foundation
import SwiftyJSON

public final class SongModel: NSObject,NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let artist = "artist"
    static let youtubeDuration = "youtube_duration"
    static let id = "id"
    static let youtubeId = "youtube_id"
    static let thumbnail = "thumbnail"
    static let itunesId = "itunes_id"
    static let cateId = "cate_id"
    static let title = "title"
    static let youtubeViews = "youtube_views"
    static let subCateId = "sub_cate_id"
  }

  // MARK: Properties
  public var artist: String?
  public var youtubeDuration: String?
  public var id: String?
  public var youtubeId: String?
  public var thumbnail: String?
  public var itunesId: String?
  public var cateId: String?
  public var title: String?
  public var youtubeViews: String?
  public var subCateId: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    artist = json[SerializationKeys.artist].string
    youtubeDuration = json[SerializationKeys.youtubeDuration].string
    id = json[SerializationKeys.id].string
    youtubeId = json[SerializationKeys.youtubeId].string
    thumbnail = json[SerializationKeys.thumbnail].string
    itunesId = json[SerializationKeys.itunesId].string
    cateId = json[SerializationKeys.cateId].string
    title = json[SerializationKeys.title].string
    youtubeViews = json[SerializationKeys.youtubeViews].string
    subCateId = json[SerializationKeys.subCateId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = artist { dictionary[SerializationKeys.artist] = value }
    if let value = youtubeDuration { dictionary[SerializationKeys.youtubeDuration] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = youtubeId { dictionary[SerializationKeys.youtubeId] = value }
    if let value = thumbnail { dictionary[SerializationKeys.thumbnail] = value }
    if let value = itunesId { dictionary[SerializationKeys.itunesId] = value }
    if let value = cateId { dictionary[SerializationKeys.cateId] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = youtubeViews { dictionary[SerializationKeys.youtubeViews] = value }
    if let value = subCateId { dictionary[SerializationKeys.subCateId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.artist = aDecoder.decodeObject(forKey: SerializationKeys.artist) as? String
    self.youtubeDuration = aDecoder.decodeObject(forKey: SerializationKeys.youtubeDuration) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.youtubeId = aDecoder.decodeObject(forKey: SerializationKeys.youtubeId) as? String
    self.thumbnail = aDecoder.decodeObject(forKey: SerializationKeys.thumbnail) as? String
    self.itunesId = aDecoder.decodeObject(forKey: SerializationKeys.itunesId) as? String
    self.cateId = aDecoder.decodeObject(forKey: SerializationKeys.cateId) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.youtubeViews = aDecoder.decodeObject(forKey: SerializationKeys.youtubeViews) as? String
    self.subCateId = aDecoder.decodeObject(forKey: SerializationKeys.subCateId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(artist, forKey: SerializationKeys.artist)
    aCoder.encode(youtubeDuration, forKey: SerializationKeys.youtubeDuration)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(youtubeId, forKey: SerializationKeys.youtubeId)
    aCoder.encode(thumbnail, forKey: SerializationKeys.thumbnail)
    aCoder.encode(itunesId, forKey: SerializationKeys.itunesId)
    aCoder.encode(cateId, forKey: SerializationKeys.cateId)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(youtubeViews, forKey: SerializationKeys.youtubeViews)
    aCoder.encode(subCateId, forKey: SerializationKeys.subCateId)
  }

    
    init(artist: String, youtubeDuration: String, id: String,thumbnail: String, itunesId: String, cateId: String, title: String, youtubeViews:String, subCateId: String, youtubeId:String){
        self.artist = artist
        self.youtubeDuration = youtubeDuration
        self.id = id
        self.thumbnail = thumbnail
        self.itunesId = itunesId
        self.youtubeId = youtubeId
        self.cateId = cateId
        self.title = title
        self.youtubeViews = youtubeViews
        self.subCateId = subCateId
        
    }

}
