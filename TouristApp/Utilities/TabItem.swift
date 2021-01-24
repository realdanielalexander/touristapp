//
//  TabItem.swift
//  TouristApp
//
//  Created by Daniel Alexander on 29/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import SwiftUI

struct TabItem: View {
    
    var imageName: String
    var title: String
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(title)
        }
    }
    
}
