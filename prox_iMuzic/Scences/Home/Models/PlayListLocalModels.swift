//
//  PlayListLocalModels.swift
//
//  Created by Nguyen Trung Hieu on 4/14/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PlayListLocalModels:  NSObject, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let title = "title"
    static let imageUrl = "ImageUrl"
    static let songNumber = "SongNumber"
    static let songModel = "SongModel"
  }

  // MARK: Properties
  public var title: String?
  public var imageUrl: String?
  public var songNumber: String?
  public var songModel: [SongModel]?

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
    title = json[SerializationKeys.title].string
    imageUrl = json[SerializationKeys.imageUrl].string
    songNumber = json[SerializationKeys.songNumber].string
    if let items = json[SerializationKeys.songModel].array { songModel = items.map { SongModel(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = imageUrl { dictionary[SerializationKeys.imageUrl] = value }
    if let value = songNumber { dictionary[SerializationKeys.songNumber] = value }
    if let value = songModel { dictionary[SerializationKeys.songModel] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.imageUrl = aDecoder.decodeObject(forKey: SerializationKeys.imageUrl) as? String
    self.songNumber = aDecoder.decodeObject(forKey: SerializationKeys.songNumber) as? String
    self.songModel = aDecoder.decodeObject(forKey: SerializationKeys.songModel) as? [SongModel]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(imageUrl, forKey: SerializationKeys.imageUrl)
    aCoder.encode(songNumber, forKey: SerializationKeys.songNumber)
    aCoder.encode(songModel, forKey: SerializationKeys.songModel)
  }
    
    init(title: String, imageUrl: String, songNumber: String, songModel: [SongModel]){
        self.title = title
        self.imageUrl = imageUrl
        self.songNumber = songNumber
        self.songModel = songModel
    }

}
