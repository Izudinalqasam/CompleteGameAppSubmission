//
//  HomeInteractor.swift
//  Submission1GameApp
//
//  Created by izzudin on 22/11/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation
import RxSwift
import Core

public protocol GameUseCase {
    func getGame(idGame: String) -> Observable<GameItemDetail>
    func getListItem() -> Observable<[GameItem]>
    func searchGame(query: String) -> Observable<[GameItem]>
    func getDetailGame(idGame: String) -> Observable<GameItemDetail>
    func saveFavorite(game: GameItemDetail) -> Completable
    func deleteGame(idGame: Int) -> Completable
}

public class GameInteractor: GameUseCase {
    private let repository: GamesRepositoryProtocol
    
    public required init(repository: GamesRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getGame(idGame: String) -> Observable<GameItemDetail> {
        return repository.getGame(idGame: idGame)
    }
    
    public func getListItem() -> Observable<[GameItem]> {
        return repository.getListItem()
    }
    
    public func searchGame(query: String) -> Observable<[GameItem]> {
        return repository.searchGame(query: query)
    }
    
    public func saveFavorite(game: GameItemDetail) -> Completable {
        return repository.saveFavorite(game: game)
    }
    
    public func deleteGame(idGame: Int) -> Completable {
        return repository.deleteGame(idGame: idGame)
    }
    
    public func getDetailGame(idGame: String) -> Observable<GameItemDetail> {
        return repository.getDetailGame(idGame: idGame)
    }
}
