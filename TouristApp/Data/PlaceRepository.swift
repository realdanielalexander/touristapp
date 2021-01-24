//
//  PlaceRepository.swift
//  TouristApp
//
//  Created by Daniel Alexander on 26/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import Combine
import RealmSwift

class PlaceRepository: NSObject {
    
    typealias PlaceInstance = (LocaleDataSource, RemoteDataSource) -> PlaceRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    init(remote: RemoteDataSource, locale: LocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: PlaceInstance = { localeRepo, remoteRepo in
        return PlaceRepository(remote: remoteRepo, locale: localeRepo)
    }
}

extension PlaceRepository: PlaceRepositoryProtocol {
    func getPlace(
        by idPlace: String
    ) -> AnyPublisher<PlaceModel, Error> {
        return self.locale.getPlace(by: idPlace)
            .flatMap { result -> AnyPublisher<PlaceModel, Error> in
                return self.locale.getPlace(by: idPlace)
                    .map { PlaceMapper.mapPlaceEntityToDomain(input: $0) }
                    .eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    func getPlaces(
    ) -> AnyPublisher<[PlaceModel], Error> {
        return self.locale.getPlaces()
            .flatMap { result -> AnyPublisher<[PlaceModel], Error> in
                if result.isEmpty {
                    return self.remote.getPlaces()
                        .map { PlaceMapper.mapPlaceResponsesToEntities(input: $0) }
                        .catch { _ in self.locale.getPlaces() }
                        .flatMap { self.locale.addPlaces(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getPlaces()
                            .map {  PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
                    }.eraseToAnyPublisher()
                } else {
                    return self.locale.getPlaces()
                        .map { PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
        }.eraseToAnyPublisher()
    }
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error> {
        return self.locale.getFavoritePlaces()
            .map { PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func updateFavoritePlace(
        by idPlace: String
    ) -> AnyPublisher<PlaceModel, Error> {
        return self.locale.updateFavoritePlace(by: idPlace)
            .map { PlaceMapper.mapPlaceEntityToDomain(input: $0) }
            .eraseToAnyPublisher()
    }
    
}
