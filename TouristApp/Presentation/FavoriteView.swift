//
//  FavoriteView.swift
//  TouristApp
//
//  Created by Daniel Alexander on 28/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        ZStack {
            List() {
                ForEach(self.presenter.places, id: \.id) { place in
                    self.presenter.linkBuilder(for: place) {
                        HStack(spacing: 16) {
                            WebImage(url: URL(string: place.image))
                                .resizable()
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .clipped()
                                .frame(width: 100, height: 100)
                                .cornerRadius(16)
                            VStack(alignment: .leading) {
                                Text(place.name).font(.headline)
                                Text("Likes: \(place.like)").font(.subheadline).opacity(0.5)
                                
                            }
                        }
                    }
                }
            }
        }.onAppear {
            self.presenter.getPlaces()
        }.navigationBarTitle(Text("Favorite Places"))
        
    }
}
