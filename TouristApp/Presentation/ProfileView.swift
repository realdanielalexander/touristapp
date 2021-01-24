//
//  ProfileView.swift
//  TouristApp
//
//  Created by Daniel Alexander on 29/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    var body: some View {
            VStack {
                Image("profile")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 160, height: 160)
                Text("Daniel Alexander").font(.headline)
                Text("realdanielalexander@gmail.com")
                    .font(.subheadline)
                    .opacity(0.5)
            }.navigationBarTitle(Text("Profile"))
    }
}
