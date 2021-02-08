//
//  DataSource.swift
//  
//
//  Created by Daniel Alexander on 24/01/21.
//

import Combine
 
public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
