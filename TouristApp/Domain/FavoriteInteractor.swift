//
//  FavoriteInteractor.swift
//  TouristApp
//
//  Created by Daniel Alexander on 28/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error>
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: PlaceRepositoryProtocol
    
    required init(repository: PlaceRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error> {
        return repository.getFavoritePlaces()
    }
    
}
