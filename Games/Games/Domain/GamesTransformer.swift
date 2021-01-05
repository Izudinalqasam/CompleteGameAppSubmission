//
//  GamesMapper.swift
//  Games
//
//  Created by izzudin on 04/01/21.
//

import Foundation
import Core

public struct GamesTransformer: Mapper {
    
    
    public typealias Response = [GameItemResponse]
    
    public typealias Entity = GameItemDetailEntity
    
    public typealias Domain = [GameItem]
    
    public init() {}
    
    public func transformResponseToEntity(response: [GameItemResponse]) -> GameItemDetailEntity {
       fatalError()
    }
    
    public func transformResponseToDomain(response: [GameItemResponse]) -> [GameItem] {
        return response.map { item in
            GameItem(
            idGame: item.idGame,
            name: item.name,
            released: item.released ?? "-",
            rating: item.rating ?? 0.0,
            backgroundImage: item.backgroundImage ?? ""
        )
        }
    }
    
    public func transformEntityToDomain(entity: GameItemDetailEntity) -> [GameItem] {
        fatalError()
    }
    
    public func transformDomainToEntity(domain: [GameItem]) -> GameItemDetailEntity {
        fatalError()
    }
}
