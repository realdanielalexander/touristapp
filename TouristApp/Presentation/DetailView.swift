//
//  DetailView.swift
//  TouristApp
//
//  Created by Daniel Alexander on 27/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        image
                        spacer
                        likeButton
                        spacer
                        content
                        spacer
                    }.padding()
                }
            }
        }.navigationBarTitle(Text(self.presenter.place.name), displayMode: .large)
    }
}

extension DetailView {
    var spacer: some View {
        Spacer()
    }
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var image: some View {
        WebImage(url: URL(string: self.presenter.place.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .cornerRadius(16)
            .padding(.all)
    }
    
    var description: some View {
        Text(self.presenter.place.description)
            .font(.system(size: 15))
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerTitle("Description")
                .padding([.top, .bottom])
            description
        }
    }
    
    var likeButton: some View {
        HStack(alignment: .center) {
            if presenter.place.favorite {
                CustomIcon(
                    imageName: "heart.fill",
                    title: "Favorited"
                ).onTapGesture { self.presenter.updateFavoritePlace() }
            } else {
                CustomIcon(
                    imageName: "heart",
                    title: "Favorite"
                ).onTapGesture { self.presenter.updateFavoritePlace() }
            }
        }
    }
}

struct CustomIcon: View {
    
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 28))
                .foregroundColor(.red)
            
            Text(title)
                .font(.caption)
                .padding(.top, 8)
        }
    }
    
}
