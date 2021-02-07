//
//  GetPlacesLocaleDataSource.swift
//  Place
//
//  Created by Daniel Alexander on 30/01/21.
//  Copyright © 2021 Daniel Inc. All rights reserved.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetPlacesLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    public typealias Response = PlaceModuleEntity
    
    private let _realm: Realm!
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[PlaceModuleEntity], Error> {
            return Future<[PlaceModuleEntity], Error> { completion in
                if self._realm != nil {
                    let places: Results<PlaceModuleEntity> = {
                        self._realm.objects(PlaceModuleEntity.self)
                    }()
                    completion(.success(places.toArray(ofType: PlaceModuleEntity.self)))
              } else {
                completion(.failure(DatabaseError.invalidInstance))
              }
            }.eraseToAnyPublisher()
    }
    
    public func listFavorites(request: Any?) -> AnyPublisher<[PlaceModuleEntity], Error> {
        return Future<[PlaceModuleEntity], Error> { completion in
          if let realm = self._realm {
            let placeEntities = {
              realm.objects(PlaceModuleEntity.self)
                .filter("favorite = \(true)")
                .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(placeEntities.toArray(ofType: PlaceModuleEntity.self)))
          } else {
            completion(.failure(DatabaseError.invalidInstance))
          }
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [PlaceModuleEntity]) -> AnyPublisher<Bool, Error> {
      return Future<Bool, Error> { completion in
        if let realm = self._realm {
          do {
            try realm.write {
              for place in entities {
                realm.add(place, update: .all)
              }
              completion(.success(true))
            }
          } catch {
            completion(.failure(DatabaseError.requestFailed))
          }
        } else {
          completion(.failure(DatabaseError.invalidInstance))
        }
      }.eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<PlaceModuleEntity, Error> {
        return Future<PlaceModuleEntity, Error> { completion in
          if let realm = self._realm {
            let places: Results<PlaceModuleEntity> = {
              realm.objects(PlaceModuleEntity.self)
                .filter("id = '\(id)'")
            }()

            guard let place = places.first else {
              completion(.failure(DatabaseError.requestFailed))
              return
            }

            completion(.success(place))
          } else {
            completion(.failure(DatabaseError.invalidInstance))
          }
        }.eraseToAnyPublisher()
    }
    
    public func update(id: String) -> AnyPublisher<PlaceModuleEntity, Error> {
        return Future<PlaceModuleEntity, Error> { completion in
          if let realm = self._realm, let placeEntity = {
            realm.objects(PlaceModuleEntity.self).filter("id = '\(id)'")
          }().first {
            do {
              try realm.write {
                placeEntity.setValue(!placeEntity.favorite, forKey: "favorite")
              }
              completion(.success(placeEntity))
            } catch {
              completion(.failure(DatabaseError.requestFailed))
            }
          } else {
            completion(.failure(DatabaseError.invalidInstance))
          }
        }.eraseToAnyPublisher()
    }
}
