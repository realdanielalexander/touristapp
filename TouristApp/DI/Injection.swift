//
//  Injection.swift
//  TouristApp
//
//  Created by Daniel Alexander on 26/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> PlaceRepositoryProtocol {
        let realm = try? Realm()
        
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return PlaceRepository.sharedInstance(locale, remote)
    }
    
    func provideHome() -> PlaceUseCase {
        let placeRepository = provideRepository()
        return PlaceInteractor(repository: placeRepository)
    }
    
    func provideDetail(place: PlaceModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, place: place)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
}
