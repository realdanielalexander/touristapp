//
//  PlacesTransformer.swift
//  Place
//
//  Created by Daniel Alexander on 30/01/21.
//  Copyright © 2021 Daniel Inc. All rights reserved.
//

import Core

public struct PlacesTransformer: Mapper {
    
    public typealias Request = Any
    
    public typealias Response = [PlaceResponse]
    
    public typealias Entity = [PlaceModuleEntity]
    
    public typealias Domain = [PlaceDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(request: Any?, response: [PlaceResponse]) -> [PlaceModuleEntity] {
        return response.map { result in
            let newPlace = PlaceModuleEntity()
            newPlace.id = "\(result.id!)"
            newPlace.name = result.name ?? "Unknown"
            newPlace.like = "\(result.like!)"
            newPlace.image = result.image ?? "Unknown"
            newPlace.desc = result.description ?? "Unknown"
            return newPlace
        }
    }
    
    
    public func transformEntityToDomain(entity: [PlaceModuleEntity]) -> [PlaceDomainModel] {
        return entity.map { result in
            return PlaceDomainModel(
                id: result.id,
                name: result.name,
                like: result.like,
                image: result.image,
                description: result.desc,
                favorite: result.favorite
            )
        }
    }
}
