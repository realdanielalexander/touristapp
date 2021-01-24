//
//  DetailInteractor.swift
//  TouristApp
//
//  Created by Daniel Alexander on 27/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import Combine

protocol DetailUseCase {
    
    func getPlace() -> PlaceModel
    func getPlace() -> AnyPublisher<PlaceModel, Error>
    func updateFavoritePlace() -> AnyPublisher<PlaceModel, Error>
}

class DetailInteractor: DetailUseCase {
    
    private let repository: PlaceRepositoryProtocol
    private let place: PlaceModel
    static private var counter = 0
    
    required init(
        repository: PlaceRepositoryProtocol,
        place: PlaceModel
    ) {
        self.repository = repository
        self.place = place
    }
    
    func getPlace() -> PlaceModel {
        return place
    }
    
    func getPlace() -> AnyPublisher<PlaceModel, Error> {
        return repository.getPlace(by: place.id)
    }
    
    func updateFavoritePlace() -> AnyPublisher<PlaceModel, Error> {
        return repository.updateFavoritePlace(by: place.id)
    }
    
}
