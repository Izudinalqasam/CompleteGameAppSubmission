//
//  GamesLocalDataSource.swift
//  Games
//
//  Created by izzudin on 04/01/21.
//

import Foundation
import Core
import RxSwift

public struct GamesLocalDataSource: LocalDataSource {
    public typealias Request = String
    public typealias Response = GameItemDetailEntity
    
    private let dataSource: FavoriteProvider
    
    public init(dataSource: FavoriteProvider) {
        self.dataSource = dataSource
    }
    
    public func list(by: String?) -> Observable<[GameItemDetailEntity]> {
        fatalError()
    }
    
    public func add(by game: GameItemDetailEntity) -> Completable {
        return dataSource.createGameFavorite(gameFavorite: game)
    }
    
    public func get(by game: String) -> Observable<GameItemDetailEntity> {
        return dataSource.getGameFavorite(idGame: game)
    }
    
    public func delete(by game: String) -> Completable {
        return dataSource.deleteGameFavorite(idGame: Int(game) ?? 0)
    }
}

