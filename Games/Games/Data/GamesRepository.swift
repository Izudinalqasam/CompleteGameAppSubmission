//
//  GamesRepository.swift
//  Games
//
//  Created by izzudin on 04/01/21.
//

import Foundation
import RxSwift
import Core

public protocol GamesRepositoryProtocol {
    func getGame(idGame: String) -> Observable<GameItemDetail>
    func getListItem() -> Observable<[GameItem]>
    func searchGame(query: String) -> Observable<[GameItem]>
    func getDetailGame(idGame: String) -> Observable<GameItemDetail>
    func saveFavorite(game: GameItemDetail) -> Completable
    func deleteGame(idGame: Int) -> Completable
}

public struct GamesRepository<
    Local: LocalDataSource,
    Transformer: Mapper,
    TransofrmerSecond: Mapper>: GamesRepositoryProtocol
where Local.Request == String,
      Local.Response == GameItemDetailEntity,
Transformer.Response == [GameItemResponse],
Transformer.Domain == [GameItem],
TransofrmerSecond.Response == GameItemDetailResponse,
TransofrmerSecond.Domain == GameItemDetail,
TransofrmerSecond.Entity == GameItemDetailEntity {
    
    private let localDataSource: Local
    private let remoteDataSource: RemoteDataSource
    private let mapper: Transformer
    private let secondMapper: TransofrmerSecond
    
    public init(local: Local, remote: RemoteDataSource, mapper: Transformer, secondMapper: TransofrmerSecond) {
        self.localDataSource = local
        self.remoteDataSource = remote
        self.mapper = mapper
        self.secondMapper = secondMapper
    }
    
    public func getGame(idGame: String) -> Observable<GameItemDetail> {
        return localDataSource.get(by: idGame)
            .map { secondMapper.transformEntityToDomain(entity: $0) }
    }
    
    public func getListItem() -> Observable<[GameItem]> {
        return remoteDataSource.getListItem()
            .map { mapper.transformResponseToDomain(response: $0) }
    }
    
    public func searchGame(query: String) -> Observable<[GameItem]> {
        return remoteDataSource.searchGame(query: query)
            .map { mapper.transformResponseToDomain(response: $0) }
    }
    
    public func getDetailGame(idGame: String) -> Observable<GameItemDetail> {
        return remoteDataSource.getDetailGame(idGame: idGame)
            .map { secondMapper.transformResponseToDomain(response: $0) }
    }
    
    public func deleteGame(idGame: Int) -> Completable {
        return localDataSource.delete(by: String(idGame))
    }
    
    public func saveFavorite(game: GameItemDetail) -> Completable {
        return localDataSource.add(by: secondMapper.transformDomainToEntity(domain: game))
    }
}
