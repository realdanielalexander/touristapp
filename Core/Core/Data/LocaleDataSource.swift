//
//  LocaleDataSource.swift
//  
//
//  Created by Daniel Alexander on 24/01/21.
//

import Combine
 
public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func listFavorites(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func get(id: String) -> AnyPublisher<Response, Error>
    func update(id: String) -> AnyPublisher<Response, Error>
}
