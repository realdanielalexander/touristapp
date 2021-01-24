//
//  RemoteDataSource.swift
//  TouristApp
//
//  Created by Daniel Alexander on 28/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {
    func getPlaces() -> AnyPublisher<[PlaceResponse], Error>
}

class RemoteDataSource: NSObject {
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getPlaces() -> AnyPublisher<[PlaceResponse], Error> {
        return Future<[PlaceResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.list.url) {
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
