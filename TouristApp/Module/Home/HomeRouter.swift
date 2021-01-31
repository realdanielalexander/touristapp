//
//  HomeRouter.swift
//  TouristApp
//
//  Created by Daniel Alexander on 27/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI
import Place
import Core

class HomeRouter {
    func makeDetailView(for place: PlaceDomainModel) -> some View {
        let detailUseCase: Interactor<String, PlaceDomainModel, GetPlaceRepository<
        GetPlacesLocaleDataSource, GetPlacesRemoteDataSource, PlaceTransformer>> = Injection.init().provideDetail(place: place)
        let favoriteUseCase: Interactor<String, PlaceDomainModel, UpdatePlaceRepository<
        GetPlacesLocaleDataSource, GetPlacesRemoteDataSource, PlaceTransformer>> = Injection.init().provideFavorite(place: place)
        let presenter = DetailPresenter(placeUseCase: detailUseCase, favoriteUseCase: favoriteUseCase, place: place)
        return DetailView(presenter: presenter)
    }
    
}
