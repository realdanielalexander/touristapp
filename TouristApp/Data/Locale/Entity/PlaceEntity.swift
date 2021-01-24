//
//  PlaceEntity.swift
//  TouristApp
//
//  Created by Daniel Alexander on 28/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import RealmSwift
class PlaceEntity: Object {
 
  @objc dynamic var id = ""
  @objc dynamic var name = ""
  @objc dynamic var like = ""
  @objc dynamic var image = ""
  @objc dynamic var desc = ""
  @objc dynamic var favorite = false
 
  override static func primaryKey() -> String? {
    return "id"
  }
 
}
