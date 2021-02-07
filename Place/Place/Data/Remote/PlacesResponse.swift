//
//  PlacesResponse.swift
//  Place
//
//  Created by Daniel Alexander on 30/01/21.
//  Copyright © 2021 Daniel Inc. All rights reserved.
//

import Foundation

public struct PlacesResponse: Decodable {
    let places: [PlaceResponse]
    
}

public struct PlaceResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case like = "like"
        case image = "image"
        case description = "description"
    }
    
    let id: Int?
    let name: String?
    let like: Int?
    let image: String?
    let description: String?
    
}
