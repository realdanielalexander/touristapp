//
//  Injection.swift
//  TouristApp
//
//  Created by Daniel Alexander on 26/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import RealmSwift
import Core
import Place
import UIKit

final class Injection: NSObject {
    
    func providePlace<U: UseCase>() -> U where U.Request == Any, U.Response == [PlaceDomainModel] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetPlacesLocaleDataSource(realm: appDelegate.realm)
        
        let remote = GetPlacesRemoteDataSource(endpoint: Endpoints.Gets.list.url)
        
        let mapper = PlacesTransformer()
        
        let repository = GetPlacesRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repository) as! U
        
    }
    
    func provideDetail<U: UseCase>(place: PlaceDomainModel) -> U where U.Request == String, U.Response == PlaceDomainModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetPlacesLocaleDataSource(realm: appDelegate.realm)
        
        let remote = GetPlacesRemoteDataSource(endpoint: Endpoints.Gets.list.url)
        
        let mapper = PlaceTransformer()
        
        let repository = GetPlaceRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper,
            place: place
            )
        
        return Interactor(repository: repository) as! U
    }
    
    func provideFavorite<U: UseCase>(place: PlaceDomainModel) -> U where U.Request == String, U.Response == PlaceDomainModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetPlacesLocaleDataSource(realm: appDelegate.realm)
        
        let remote = GetPlacesRemoteDataSource(endpoint: Endpoints.Gets.list.url)
        
        let mapper = PlaceTransformer()
        
        let repository = UpdatePlaceRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper,
            place: place
            )
        
        return Interactor(repository: repository) as! U
    }
    
    
    
    func provideFavoriteMenu<U: UseCase>() -> U where U.Request == Any, U.Response == [PlaceDomainModel] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetPlacesLocaleDataSource(realm: appDelegate.realm)
        
        let remote = GetPlacesRemoteDataSource(endpoint: Endpoints.Gets.list.url)
        
        let mapper = PlacesTransformer()
        
        let repository = GetFavoritePlacesRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repository) as! U
        
    }
    
}
