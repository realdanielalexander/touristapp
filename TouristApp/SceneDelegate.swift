//
//  SceneDelegate.swift
//  TouristApp
//
//  Created by Daniel Alexander on 26/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let homeUseCase = Injection.init().provideHome()
        let favoriteUseCase = Injection.init().provideFavorite()
        let homePresenter = PlacePresenter(useCase: homeUseCase)
        let favoritePresenter = FavoritePresenter(useCase: favoriteUseCase)
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
