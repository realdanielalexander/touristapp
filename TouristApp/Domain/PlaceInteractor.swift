//
//  PlaceInteractor.swift
//  TouristApp
//
//  Created by Daniel Alexander on 26/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import Combine

protocol PlaceUseCase {
    func getPlaces() -> AnyPublisher<[PlaceModel], Error>
}

class PlaceInteractor: PlaceUseCase {
    private let repository: PlaceRepositoryProtocol
    
    init(repository: PlaceRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPlaces() -> AnyPublisher<[PlaceModel], Error> {
        return repository.getPlaces()
    }
}
