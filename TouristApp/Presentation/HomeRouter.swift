//
//  HomeRouter.swift
//  TouristApp
//
//  Created by Daniel Alexander on 27/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI

class HomeRouter {
    
    func makeDetailView(for place: PlaceModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(place: place)
        let presenter = DetailPresenter(detailUseCase: detailUseCase, place: place)
        return DetailView(presenter: presenter)
    }
    
}
