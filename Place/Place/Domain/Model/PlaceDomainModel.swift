//
//  PlaceDomainModel.swift
//  Place
//
//  Created by Daniel Alexander on 30/01/21.
//  Copyright © 2021 Daniel Inc. All rights reserved.
//

import Foundation

public struct PlaceDomainModel: Equatable, Identifiable {
    public let id: String
    public let name: String
    public let like: String
    public let image: String
    public let description: String
    public var favorite: Bool = false
    
    public init(id: String, name: String, like: String, image: String, description: String, favorite: Bool) {
        self.id = id
        self.name = name
        self.like = like
        self.image = image
        self.description = description
        self.favorite = favorite
    }
}
