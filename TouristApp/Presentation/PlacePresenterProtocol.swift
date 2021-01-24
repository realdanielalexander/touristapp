//
//  PlacePresenterProtocol.swift
//  TouristApp
//
//  Created by Daniel Alexander on 26/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import Combine

protocol PlacePresenterProtocol: class {
    func getPlaces() -> AnyPublisher<[PlaceModel], Error>
}
