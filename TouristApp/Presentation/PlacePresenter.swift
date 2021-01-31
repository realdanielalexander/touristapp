//
//  PlacePresenter.swift
//  TouristApp
//
//  Created by Daniel Alexander on 26/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI
import Combine
import Place

class PlacePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let placeUseCase: PlaceUseCase
    
    @Published var places: [PlaceModel] = []
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    init(useCase: PlaceUseCase) {
        self.placeUseCase = useCase
    }
    
    func getPlaces() {
        isLoading = true
        placeUseCase.getPlaces()
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
        destination: router.makeDetailView(for: place)) { content() }
    }
}
