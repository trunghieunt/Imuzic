//
//  SearchModels.swift
//
//  Created by Nguyen Trung Hieu on 4/14/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SearchModels: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let title = "title"
    static let thumb = "thumb"
    static let thumbnail = "thumbnail"
    static let id = "id"
    static let author = "author"
    static let url = "url"
  }

  // MARK: Properties
  public var title: String?
  public var thumb: String?
  public var thumbnail: String?
  public var id: String?
  public var author: String?
  public var url: String?

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
    thumb = json[SerializationKeys.thumb].string
    thumbnail = json[SerializationKeys.thumbnail].string
    id = json[SerializationKeys.id].string
    author = json[SerializationKeys.author].string
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = thumb { dictionary[SerializationKeys.thumb] = value }
    if let value = thumbnail { dictionary[SerializationKeys.thumbnail] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = author { dictionary[SerializationKeys.author] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.thumb = aDecoder.decodeObject(forKey: SerializationKeys.thumb) as? String
    self.thumbnail = aDecoder.decodeObject(forKey: SerializationKeys.thumbnail) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.author = aDecoder.decodeObject(forKey: SerializationKeys.author) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(thumb, forKey: SerializationKeys.thumb)
    aCoder.encode(thumbnail, forKey: SerializationKeys.thumbnail)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(author, forKey: SerializationKeys.author)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
