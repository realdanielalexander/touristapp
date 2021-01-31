//
//  FavoritePresenter.swift
//  TouristApp
//
//  Created by Daniel Alexander on 28/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI
import Combine
import Place

class FavoritePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var places: [PlaceModel] = []
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    init(useCase: FavoriteUseCase) {
        self.favoriteUseCase = useCase
    }
    
    func getPlaces() {
        isLoading = true
        favoriteUseCase.getFavoritePlaces()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { places in
                self.places = places
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for place: PlaceDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
        destination: HomeRouter().makeDetailView(for: place)) { content() }
    }
}
