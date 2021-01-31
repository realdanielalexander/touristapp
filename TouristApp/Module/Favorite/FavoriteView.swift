//
//  FavoriteView.swift
//  TouristApp
//
//  Created by Daniel Alexander on 28/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Place

struct FavoriteView: View {
    
    @ObservedObject var presenter: GetListPresenter<Any, PlaceDomainModel, Interactor<Any, [PlaceDomainModel], GetFavoritePlacesRepository<GetPlacesLocaleDataSource, GetPlacesRemoteDataSource, PlacesTransformer>>>
    
    var body: some View {
        ZStack {
            if self.presenter.isLoading {
                loadingIndicator
            } else if self.presenter.isError {
                errorIndicator
            } else if self.presenter.list.isEmpty {
                emptyCategories
            } else {
                content
            }
            
        }.onAppear {
            self.presenter.getList(request: nil)
        }.navigationBarTitle(Text("Favorite Places"))
        
    }
}

extension FavoriteView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        )
    }
    
    var emptyCategories: some View {
        CustomEmptyView(
            image: "airplane",
            title: "Start adding your favorite places!"
        )
    }
    
    var content: some View {
        List() {
            ForEach(self.presenter.list) { place in
                self.linkBuilder(for: place) {
                    PlaceRow(place: place)
                }
            }
        }
    }
    
    func linkBuilder<Content: View>(
        for place: PlaceDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: place)
        ) { content() }
    }
}
