//
//  HomeView.swift
//  TouristApp
//
//  Created by Daniel Alexander on 27/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Place

struct HomeView: View {
    
    @ObservedObject var presenter: GetListPresenter<Any, PlaceDomainModel, Interactor<Any, [PlaceDomainModel], GetPlacesRepository<GetPlacesLocaleDataSource, GetPlacesRemoteDataSource, PlacesTransformer>>>
    
    var body: some View {
        ZStack {
            List() {
                ForEach(self.presenter.list) { place in
                    self.linkBuilder(for: place) {
                        PlaceRow(place: place)
                    }
                }
            }
        }.onAppear {
            self.presenter.getList(request: nil)
        }.navigationBarTitle(Text("Tourism App"))
    }
}

extension HomeView {
    func linkBuilder<Content: View>(
        for place: PlaceDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: place)
        ) { content() }
    }
}
