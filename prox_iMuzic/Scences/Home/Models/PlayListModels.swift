//
//  PlayListModels.swift
//
//  Created by Nguyen Trung Hieu on 4/9/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PlayListModels: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let playlistBackupId = "playlistBackupId"
    static let channelId = "channelId"
    static let playlistThumbHigh = "playlistThumbHigh"
    static let playlistSubTitle = "playlistSubTitle"
    static let channelTitle = "channelTitle"
    static let id = "id"
    static let publishedTime = "publishedTime"
    static let playlistDescription = "playlistDescription"
    static let cateId = "cate_id"
    static let title = "title"
    static let playlistThumbMedium = "playlistThumbMedium"
    static let playlistId = "playlistId"
    static let playlistThumbDefault = "playlistThumbDefault"
  }

  // MARK: Properties
  public var playlistBackupId: String?
  public var channelId: String?
  public var playlistThumbHigh: String?
  public var playlistSubTitle: String?
  public var channelTitle: String?
  public var id: String?
  public var publishedTime: String?
  public var playlistDescription: String?
  public var cateId: String?
  public var title: String?
  public var playlistThumbMedium: String?
  public var playlistId: String?
  public var playlistThumbDefault: String?

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
    playlistBackupId = json[SerializationKeys.playlistBackupId].string
    channelId = json[SerializationKeys.channelId].string
    playlistThumbHigh = json[SerializationKeys.playlistThumbHigh].string
    playlistSubTitle = json[SerializationKeys.playlistSubTitle].string
    channelTitle = json[SerializationKeys.channelTitle].string
    id = json[SerializationKeys.id].string
    publishedTime = json[SerializationKeys.publishedTime].string
    playlistDescription = json[SerializationKeys.playlistDescription].string
    cateId = json[SerializationKeys.cateId].string
    title = json[SerializationKeys.title].string
    playlistThumbMedium = json[SerializationKeys.playlistThumbMedium].string
    playlistId = json[SerializationKeys.playlistId].string
    playlistThumbDefault = json[SerializationKeys.playlistThumbDefault].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = playlistBackupId { dictionary[SerializationKeys.playlistBackupId] = value }
    if let value = channelId { dictionary[SerializationKeys.channelId] = value }
    if let value = playlistThumbHigh { dictionary[SerializationKeys.playlistThumbHigh] = value }
    if let value = playlistSubTitle { dictionary[SerializationKeys.playlistSubTitle] = value }
    if let value = channelTitle { dictionary[SerializationKeys.channelTitle] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = publishedTime { dictionary[SerializationKeys.publishedTime] = value }
    if let value = playlistDescription { dictionary[SerializationKeys.playlistDescription] = value }
    if let value = cateId { dictionary[SerializationKeys.cateId] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = playlistThumbMedium { dictionary[SerializationKeys.playlistThumbMedium] = value }
    if let value = playlistId { dictionary[SerializationKeys.playlistId] = value }
    if let value = playlistThumbDefault { dictionary[SerializationKeys.playlistThumbDefault] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.playlistBackupId = aDecoder.decodeObject(forKey: SerializationKeys.playlistBackupId) as? String
    self.channelId = aDecoder.decodeObject(forKey: SerializationKeys.channelId) as? String
    self.playlistThumbHigh = aDecoder.decodeObject(forKey: SerializationKeys.playlistThumbHigh) as? String
    self.playlistSubTitle = aDecoder.decodeObject(forKey: SerializationKeys.playlistSubTitle) as? String
    self.channelTitle = aDecoder.decodeObject(forKey: SerializationKeys.channelTitle) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.publishedTime = aDecoder.decodeObject(forKey: SerializationKeys.publishedTime) as? String
    self.playlistDescription = aDecoder.decodeObject(forKey: SerializationKeys.playlistDescription) as? String
    self.cateId = aDecoder.decodeObject(forKey: SerializationKeys.cateId) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.playlistThumbMedium = aDecoder.decodeObject(forKey: SerializationKeys.playlistThumbMedium) as? String
    self.playlistId = aDecoder.decodeObject(forKey: SerializationKeys.playlistId) as? String
    self.playlistThumbDefault = aDecoder.decodeObject(forKey: SerializationKeys.playlistThumbDefault) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(playlistBackupId, forKey: SerializationKeys.playlistBackupId)
    aCoder.encode(channelId, forKey: SerializationKeys.channelId)
    aCoder.encode(playlistThumbHigh, forKey: SerializationKeys.playlistThumbHigh)
    aCoder.encode(playlistSubTitle, forKey: SerializationKeys.playlistSubTitle)
    aCoder.encode(channelTitle, forKey: SerializationKeys.channelTitle)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(publishedTime, forKey: SerializationKeys.publishedTime)
    aCoder.encode(playlistDescription, forKey: SerializationKeys.playlistDescription)
    aCoder.encode(cateId, forKey: SerializationKeys.cateId)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(playlistThumbMedium, forKey: SerializationKeys.playlistThumbMedium)
    aCoder.encode(playlistId, forKey: SerializationKeys.playlistId)
    aCoder.encode(playlistThumbDefault, forKey: SerializationKeys.playlistThumbDefault)
  }

}
