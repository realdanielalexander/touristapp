//
//  PlaceRepositoryProtocol.swift
//  TouristApp
//
//  Created by Daniel Alexander on 26/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import Combine

protocol PlaceRepositoryProtocol {
    func getPlace(by idPlace: String) -> AnyPublisher<PlaceModel, Error>
    func getPlaces() -> AnyPublisher<[PlaceModel], Error>
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error>
    func updateFavoritePlace(
        by idPlace: String
    ) -> AnyPublisher<PlaceModel, Error>
}
