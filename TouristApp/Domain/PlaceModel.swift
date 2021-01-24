//
//  PlaceEntity.swift
//  TouristApp
//
//  Created by Daniel Alexander on 26/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation

struct PlaceModel: Identifiable {
    let id: String
    let name: String
    let like: String
    let image: String
    let description: String
    var favorite: Bool = false
}
