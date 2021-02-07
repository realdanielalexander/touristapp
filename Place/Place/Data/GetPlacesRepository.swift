//
//  GetPlacesRepository.swift
//  Place
//
//  Created by Daniel Alexander on 30/01/21.
//  Copyright © 2021 Daniel Inc. All rights reserved.
//

import Core
import Combine

public struct GetPlacesRepository <
    PlaceLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    PlaceLocaleDataSource.Response == PlaceModuleEntity,
    RemoteDataSource.Response == [PlaceResponse],
    Transformer.Response == [PlaceResponse],
    Transformer.Entity == [PlaceModuleEntity],
    Transformer.Domain == [PlaceDomainModel] {
    
    public typealias Request = Any
    
    public typealias Response = [PlaceDomainModel]
    
    private let _localeDataSource: PlaceLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: PlaceLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer
    ) {
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[PlaceDomainModel], Error> {
        return self._localeDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[PlaceDomainModel], Error> in
                if result.isEmpty {
                    return self._remoteDataSource.execute(request: nil)
                        .map { self._mapper.transformResponseToEntity(request: nil, response: $0) }
                        .catch { _ in self._localeDataSource.list(request: nil) }
                        .flatMap { self._localeDataSource.add(entities: $0) }
                        .filter { $0 }
                        .flatMap { _ in self._localeDataSource.list(request: nil)
                            .map {  self._mapper.transformEntityToDomain(entity: $0)}
                    }.eraseToAnyPublisher()
                } else {
                    return self._localeDataSource.list(request: nil)
                        .map { self._mapper.transformEntityToDomain(entity: $0)}
                        .eraseToAnyPublisher()
                }
        }.eraseToAnyPublisher()
    }
}

