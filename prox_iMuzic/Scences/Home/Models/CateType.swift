//
//  CateType.swift
//
//  Created by Nguyen Trung Hieu on 4/8/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class CateType: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let title = "title"
    static let idKey = "id_key"
  }

  // MARK: Properties
  public var id: String?
  public var title: String?
  public var idKey: String?

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
    id = json[SerializationKeys.id].string
    title = json[SerializationKeys.title].string
    idKey = json[SerializationKeys.idKey].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = idKey { dictionary[SerializationKeys.idKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.idKey = aDecoder.decodeObject(forKey: SerializationKeys.idKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(idKey, forKey: SerializationKeys.idKey)
  }

}
