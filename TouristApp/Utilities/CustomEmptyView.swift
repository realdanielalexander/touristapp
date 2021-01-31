//
//  CustomEmptyView.swift
//  TouristApp
//
//  Created by Daniel Alexander on 30/01/21.
//  Copyright © 2021 Daniel Inc. All rights reserved.
//

import SwiftUI

struct CustomEmptyView: View {
  var image: String
  var title: String
  
  var body: some View {
    VStack {
        Image(systemName: image)
        .resizable()
        .renderingMode(.template)
        .scaledToFit()
            .foregroundColor(.gray)
        .frame(width: 50)
      Text(title)
        .font(.system(.body, design: .rounded))
    }
  }
}
