//
//  SceneDelegate.swift
//  TouristApp
//
//  Created by Daniel Alexander on 26/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import UIKit
import SwiftUI
import Core
import Place

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let homeUseCase: Interactor<
            Any, [PlaceDomainModel], GetPlacesRepository<
                GetPlacesLocaleDataSource,
                GetPlacesRemoteDataSource,
                PlacesTransformer
            >
            > = Injection.init().providePlace()
        
        let homePresenter = GetListPresenter(useCase: homeUseCase)
        
        let favoriteUseCase: Interactor<
            Any, [PlaceDomainModel], GetFavoritePlacesRepository<
            GetPlacesLocaleDataSource,
            GetPlacesRemoteDataSource,
            PlacesTransformer
            >
            > = Injection.init().provideFavoriteMenu()
        let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
        
        let contentView = ContentView()
            .environmentObject(homePresenter)
            .environmentObject(favoritePresenter)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
