//
//  PlaceRow.swift
//  TouristApp
//
//  Created by Daniel Alexander on 30/01/21.
//  Copyright © 2021 Daniel Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Place

struct PlaceRow: View {
    init(place: PlaceDomainModel) {
        self.place = place
    }
    var place: PlaceDomainModel
    var body: some View {
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

extension PlaceRow {
    func linkBuilder<Content: View>(
        for place: PlaceDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
        destination: HomeRouter().makeDetailView(for: place)) { content() }
    }
}
