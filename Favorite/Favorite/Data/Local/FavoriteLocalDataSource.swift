//
//  FavoriteLocalDataSource.swift
//  Favorite
//
//  Created by izzudin on 04/01/21.
//

import Foundation
import Core
import RxSwift
import Games

public struct FavoriteLocalDataSource: LocalDataSource {
    public typealias Request = String
    public typealias Response = GameItemDetailEntity
    
    private let dataSource: FavoriteProvider
    
    public init(dataSource: FavoriteProvider) {
        self.dataSource = dataSource
    }
    
    public func list(by: String?) -> Observable<[GameItemDetailEntity]> {
        return dataSource.getAllGameFavorites()
    }
    
    public func add(by game: GameItemDetailEntity) -> Completable {
        fatalError()
    }
    
    public func get(by game: String) -> Observable<GameItemDetailEntity> {
        fatalError()
    }
    
    public func delete(by game: String) -> Completable {
        fatalError()
    }
}
