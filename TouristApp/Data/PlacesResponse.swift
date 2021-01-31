//
//  PlaceResponse.swift
//  TouristApp
//
//  Created by Daniel Alexander on 27/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
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
