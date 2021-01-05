//
//  GamesDetailTransformer.swift
//  Games
//
//  Created by izzudin on 04/01/21.
//

import Foundation
import Core

public struct GamesDetailTransformer: Mapper {
    
    public typealias Entity = GameItemDetailEntity
    
    public typealias Domain = GameItemDetail
    
    public typealias Response = GameItemDetailResponse
    
    public init() {}
    
    public func transformResponseToEntity(response: GameItemDetailResponse) -> GameItemDetailEntity {
        fatalError()
    }
    
    public func transformResponseToDomain(response: GameItemDetailResponse) -> GameItemDetail {
        return GameItemDetail(
            idGame: response.idGame,
            name: response.name,
            released: response.released,
            rating: response.rating,
            backgroundImage: response.backgroundImage,
            description: response.description
        )
    }
    
    public func transformEntityToDomain(entity: GameItemDetailEntity) -> GameItemDetail {
        return GameItemDetail(
            idGame: entity.idGame,
            name: entity.name,
            released: entity.released,
            rating: entity.rating,
            backgroundImage: entity.backgroundImage,
            description: entity.description
        )
    }
    
    public func transformDomainToEntity(domain: GameItemDetail) -> GameItemDetailEntity {
        return GameItemDetailEntity(
            idGame: domain.idGame,
            name: domain.name,
            released: domain.released,
            rating: domain.rating,
            backgroundImage: domain.backgroundImage,
            description: domain.description
        )
    }
}
