//
//  GetPlacesRemoteDataSource.swift
//  Place
//
//  Created by Daniel Alexander on 30/01/21.
//  Copyright © 2021 Daniel Inc. All rights reserved.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetPlacesRemoteDataSource : DataSource {
    public typealias Request = Any
    
    public typealias Response = [PlaceResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        self._endpoint = endpoint
    }
    
    public func execute(request: Any?) -> AnyPublisher<[PlaceResponse], Error> {
           return Future<[PlaceResponse], Error> { completion in
            if let url = URL(string: self._endpoint) {
                   AF.request(url)
                       .validate()
                       .responseDecodable(of: PlacesResponse.self) { response in
                           switch response.result {
                           case .success(let value):
                               completion(.success(value.places))
                           case .failure:
                               completion(.failure(URLError.invalidResponse))
                           }
                   }
               }
           }.eraseToAnyPublisher()
       }
    
}
