//
//  UpdatePlaceRepository.swift
//  Place
//
//  Created by Daniel Alexander on 30/01/21.
//  Copyright © 2021 Daniel Inc. All rights reserved.
//

import Core
import Combine

public struct UpdatePlaceRepository <
    PlaceLocaleDataSource: LocaleDataSource,
    PlaceRemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    PlaceLocaleDataSource.Request == Any,
    PlaceLocaleDataSource.Response == PlaceModuleEntity,
    Transformer.Request == Any,
    Transformer.Response == PlaceResponse,
    Transformer.Entity == PlaceModuleEntity,
Transformer.Domain == PlaceDomainModel {
    
    public typealias Request = String
    
    public typealias Response = PlaceDomainModel
    
    private let _localeDataSource: PlaceLocaleDataSource
    private let _mapper: Transformer
    private let place: PlaceDomainModel
    
    public init(
        localeDataSource: PlaceLocaleDataSource,
        remoteDataSource: PlaceRemoteDataSource,
        mapper: Transformer,
        place: PlaceDomainModel
    ) {
        _localeDataSource = localeDataSource
        _mapper = mapper
        self.place = place
    }
    
    public func execute(request: String?) -> AnyPublisher<PlaceDomainModel, Error> {
        return self._localeDataSource.update(id: request!)
            .map { self._mapper.transformEntityToDomain(entity: $0) }
        .eraseToAnyPublisher()
    }
}

