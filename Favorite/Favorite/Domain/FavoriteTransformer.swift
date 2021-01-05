//
//  FavoriteMapper.swift
//  Favorite
//
//  Created by izzudin on 04/01/21.
//

import Foundation
import Core
import Games

public struct FavoriteTransformer: Mapper {
    
    public typealias Response = GameItemDetailResponse
    
    public typealias Entity = [GameItemDetailEntity]
    
    public typealias Domain = [GameItemDetail]
    
    public init() {}
    
    public func transformResponseToEntity(response: GameItemDetailResponse) -> [GameItemDetailEntity] {
        fatalError()
    }
    
    public func transformResponseToDomain(response: GameItemDetailResponse) -> [GameItemDetail] {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: [GameItemDetailEntity]) -> [GameItemDetail] {
        return entity.map { item in
            GameItemDetail(
                idGame: item.idGame,
                name: item.name,
                released: item.released,
                rating: item.rating,
                backgroundImage: item.backgroundImage,
                description: item.description
            )
        }
    }
    
    public func transformDomainToEntity(domain: [GameItemDetail]) -> [GameItemDetailEntity ]{
        fatalError()
    }
}
