//
//  LocaleDataSource.swift
//  TouristApp
//
//  Created by Daniel Alexander on 28/11/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation
import RealmSwift
import Combine
 
protocol LocaleDataSourceProtocol: class {
 
  func addPlaces(from places: [PlaceEntity]) -> AnyPublisher<Bool, Error>
  func getPlaces() -> AnyPublisher<[PlaceEntity], Error>
 
}
 
final class LocaleDataSource: NSObject {
 
  private let realm: Realm?
  private init(realm: Realm?) {
    self.realm = realm
  }
  static let sharedInstance: (Realm?) -> LocaleDataSource = {
    realmDatabase in return LocaleDataSource(realm: realmDatabase)
  }
 
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getPlace(
      by idPlace: String
    ) -> AnyPublisher<PlaceEntity, Error> {
      return Future<PlaceEntity, Error> { completion in
        if let realm = self.realm {
          let places: Results<PlaceEntity> = {
            realm.objects(PlaceEntity.self)
              .filter("id = '\(idPlace)'")
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

    
 
    func addPlaces(
      from places: [PlaceEntity]
    ) -> AnyPublisher<Bool, Error> {
      return Future<Bool, Error> { completion in
        if let realm = self.realm {
          do {
            try realm.write {
              for place in places {
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
    
  func getPlaces(
  ) -> AnyPublisher<[PlaceEntity], Error> {
    return Future<[PlaceEntity], Error> { completion in
      if let realm = self.realm {
        let places: Results<PlaceEntity> = {
          realm.objects(PlaceEntity.self)
        }()
        completion(.success(places.toArray(ofType: PlaceEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceEntity], Error> {
      return Future<[PlaceEntity], Error> { completion in
        if let realm = self.realm {
          let placeEntities = {
            realm.objects(PlaceEntity.self)
              .filter("favorite = \(true)")
              .sorted(byKeyPath: "name", ascending: true)
          }()
          completion(.success(placeEntities.toArray(ofType: PlaceEntity.self)))
        } else {
          completion(.failure(DatabaseError.invalidInstance))
        }
      }.eraseToAnyPublisher()
    }
    
    func updateFavoritePlace(
      by idPlace: String
    ) -> AnyPublisher<PlaceEntity, Error> {
      return Future<PlaceEntity, Error> { completion in
        if let realm = self.realm, let placeEntity = {
          realm.objects(PlaceEntity.self).filter("id = '\(idPlace)'")
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
 
extension Results {
 
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
 
}
