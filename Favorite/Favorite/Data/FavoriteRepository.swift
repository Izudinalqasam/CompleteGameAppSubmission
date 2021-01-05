//
//  FavoriteRepository.swift
//  Favorite
//
//  Created by izzudin on 04/01/21.
//

import Foundation
import RxSwift
import Core
import Games

public struct FavoriteRepository<
    Local: LocalDataSource,
    Transformer: Mapper>: Repository
where Local.Response == GameItemDetailEntity,
      Local.Request == String,
      Transformer.Domain == [GameItemDetail],
      Transformer.Entity == [GameItemDetailEntity] {
    
    public typealias Request = String
    public typealias Response = [GameItemDetail]
    
    private let _mapper: Transformer
    private let _local: Local
    
    public init(local: Local, mapper: Transformer) {
        _local = local
        _mapper = mapper
    }
    
    public func execute(request: String?) -> Observable<[GameItemDetail]> {
        return _local.list(by: request).map { _mapper.transformEntityToDomain(entity: $0)
        }
    }
}
