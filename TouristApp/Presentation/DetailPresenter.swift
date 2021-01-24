//
//  DetailPresenter.swift
//  TouristApp
//
//  Created by Daniel Alexander on 27/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var place: PlaceModel
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    init(detailUseCase: DetailUseCase,
         place: PlaceModel) {
        self.detailUseCase = detailUseCase
        self.place = detailUseCase.getPlace()
        
    }
    func getPlace() {
        isLoading = true
        detailUseCase.getPlace()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { place in
                self.place = place
            })
            .store(in: &cancellables)
    }
    
    func updateFavoritePlace() {
        detailUseCase.updateFavoritePlace()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { place in
                self.place = place
            })
            .store(in: &cancellables)
    }
}
