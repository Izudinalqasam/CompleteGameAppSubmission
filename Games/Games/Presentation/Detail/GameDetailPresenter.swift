//
//  GameDetailPresenter.swift
//  Games
//
//  Created by izzudin on 05/01/21.
//

import Foundation
import RxSwift
import Core

public protocol GameDetailContractView {
    func onStopLoading()
    func onStartLoading()
    func onGettingGame(item: GameItemDetail)
    func onSavedGame()
    func onDeletedGame()
    func onGettingDetailGame(item: GameItemDetail)
}

public class GameDetailPresenter {
    private let useCase: GameUseCase
    private let disposeBag = DisposeBag()
    var listener: GameDetailContractView?
    
    public init(useCase: GameUseCase) {
        self.useCase = useCase
    }
    
    func getGame(idGame: String) {
        useCase.getGame(idGame: idGame)
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self.listener?.onGettingGame(item: result)
            }.disposed(by: disposeBag)
    }
    
    func saveFavorite(game: GameItemDetail) {
        useCase.saveFavorite(game: game)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.listener?.onSavedGame()
            }.disposed(by: disposeBag)
    }
    
    func deleteGame(idGame: Int) {
        useCase.deleteGame(idGame: idGame)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.listener?.onDeletedGame()
            }.disposed(by: disposeBag)
    }
    
    func getDetailGame(idGame: String) {
        listener?.onStartLoading()
        useCase.getDetailGame(idGame: idGame)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                self.listener?.onGettingDetailGame(item: result)
                self.listener?.onStopLoading()
            }, onError: { _ in
                self.listener?.onStopLoading()
            }).disposed(by: disposeBag)
    }
}
