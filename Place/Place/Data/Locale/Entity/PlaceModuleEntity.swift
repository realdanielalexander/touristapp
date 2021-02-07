//
//  PlaceModuleEntity.swift
//  Place
//
//  Created by Daniel Alexander on 30/01/21.
//  Copyright © 2021 Daniel Inc. All rights reserved.
//

import Foundation
import RealmSwift

public class PlaceModuleEntity: Object {
 
  @objc dynamic var id = ""
  @objc dynamic var name = ""
  @objc dynamic var like = ""
  @objc dynamic var image = ""
  @objc dynamic var desc = ""
  @objc dynamic var favorite = false
 
  public override static func primaryKey() -> String? {
    return "id"
  }
 
}
