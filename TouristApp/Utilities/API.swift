//
//  API.swift
//  TouristApp
//
//  Created by Daniel Alexander on 27/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation

struct API {
    
    static let baseUrl = "https://tourism-api.dicoding.dev/"
    
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case list
        
        public var url: String {
            switch self {
            case .list: return "\(API.baseUrl)list"
            }
        }
    }
    
}
