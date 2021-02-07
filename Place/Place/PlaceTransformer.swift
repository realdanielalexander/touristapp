//
//  PlaceTransformer.swift
//  Place
//
//  Created by Daniel Alexander on 30/01/21.
//  Copyright © 2021 Daniel Inc. All rights reserved.
//

import Core

public struct PlaceTransformer: Mapper {
    
    public typealias Request = Any
    
    public typealias Response = PlaceResponse
    
    public typealias Entity = PlaceModuleEntity
    
    public typealias Domain = PlaceDomainModel
    
    public init() {}
    
    public func transformResponseToEntity(request: Any?, response: PlaceResponse) -> PlaceModuleEntity {
        let newPlace = PlaceModuleEntity()
        newPlace.id = "\(response.id!)"
        newPlace.name = response.name ?? "Unknown"
        newPlace.like = "\(response.like!)"
        newPlace.image = response.image ?? "Unknown"
        newPlace.desc = response.description ?? "Unknown"
            
        return newPlace
        
    }
    
    
    public func transformEntityToDomain(entity: PlaceModuleEntity) -> PlaceDomainModel {
        return PlaceDomainModel(
            id: entity.id,
            name: entity.name,
            like: entity.like,
            image: entity.image,
            description: entity.desc,
            favorite: entity.favorite
        )
    }
}
