//
//  PlaceMapper.swift
//  TouristApp
//
//  Created by Daniel Alexander on 27/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

final class PlaceMapper {
    
    static func mapPlaceResponsesToDomains(
        input placeResponses: [PlaceResponse]
    ) -> [PlaceModel] {
        
        return placeResponses.map { result in
            return PlaceModel(
                id:  "\(result.id!)",
                name: result.name ?? "Unknown",
                like: "\(result.like!)",
                image: result.image ?? "Unknow",
                description: result.description ?? "Unknown"
            )
        }
    }
    
    static func mapPlaceResponsesToEntities(
        input placeResponses: [PlaceResponse]
    ) -> [PlaceEntity] {
        
        return placeResponses.map { result in
            let newPlace = PlaceEntity()
            newPlace.id = "\(result.id!)"
            newPlace.name = result.name ?? "Unknown"
            newPlace.like = "\(result.like!)"
            newPlace.image = result.image ?? "Unknown"
            newPlace.desc = result.description ?? "Unknown"
            return newPlace
        }
    }
    
    static func mapPlaceEntitiesToDomains(
        input placeEntities: [PlaceEntity]
    ) -> [PlaceModel] {
        
        return placeEntities.map { result in
            return PlaceModel(
                id: result.id,
                name: result.name,
                like: result.like,
                image: result.image,
                description: result.desc,
                favorite: result.favorite
            )
        }
    }
    
    static func mapPlaceEntityToDomain(
        input placeEntity: PlaceEntity
    ) -> PlaceModel {
        return PlaceModel(
            id: placeEntity.id,
            name: placeEntity.name,
            like: placeEntity.like,
            image: placeEntity.image,
            description: placeEntity.desc,
            favorite: placeEntity.favorite
        )
        
    }
    
}
