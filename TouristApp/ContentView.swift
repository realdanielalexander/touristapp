//
//  ContentView.swift
//  TouristApp
//
//  Created by Daniel Alexander on 26/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @EnvironmentObject var homePresenter: PlacePresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }.tabItem {
                Image(systemName: "list.dash")
                Text("Home")
            }
            NavigationView {
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                Image(systemName: "heart.fill")
                Text("Favorites")
            }
            NavigationView {
                ProfileView()
            }.tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
