//
//  DetailPresenter.swift
//  TouristApp
//
//  Created by Daniel Alexander on 27/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import Combine
import Core
import Place

public class DetailPresenter<PlaceUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject
where
    PlaceUseCase.Request == String, PlaceUseCase.Response == PlaceDomainModel,
    FavoriteUseCase.Request == String, FavoriteUseCase.Response == PlaceDomainModel
{
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _placeUseCase: PlaceUseCase
    private let _favoriteUseCase: FavoriteUseCase
    
    @Published public var place: PlaceDomainModel
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(placeUseCase: PlaceUseCase, favoriteUseCase: FavoriteUseCase, place: PlaceDomainModel) {
        self._placeUseCase = placeUseCase
        self._favoriteUseCase = favoriteUseCase
        self.place = place
    }
    
    public func getPlace(request: PlaceUseCase.Request) {
        isLoading = true
        _placeUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.place = item
            })
            .store(in: &cancellables)
    }
    
    public func updateFavoritePlace(request: FavoriteUseCase.Request) {
        _favoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.place = item
            })
            .store(in: &cancellables)
    }
    
}
