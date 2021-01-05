//
//  HomePresenter.swift
//  Submission1GameApp
//
//  Created by izzudin on 21/11/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation
import RxSwift

public protocol HomeContractView {
    func onGetListItem(items: [GameItem])
    func onGameFound(items: [GameItem])
    func onStartLoading()
    func onStopLoading()
    func onErrorState(error: Error)
}

public class HomePresenter {
    private let useCase: GameUseCase
    private let disposeBag = DisposeBag()
    var listener: HomeContractView?
    
    public init(useCase: GameUseCase) {
        self.useCase = useCase
    }
    
    func getListItem() {
        listener?.onStartLoading()
        useCase.getListItem()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                self.listener?.onStopLoading()
                self.listener?.onGetListItem(items: result)
            }, onError: { error in
                self.listener?.onStopLoading()
                self.listener?.onErrorState(error: error)
            }).disposed(by: disposeBag)
    }
    
    func searchGame(query: String) {
        listener?.onStartLoading()
        useCase.searchGame(query: query)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (result) in
                self.listener?.onStopLoading()
                self.listener?.onGameFound(items: result)
            }, onError: { (error) in
                self.listener?.onStopLoading()
                self.listener?.onErrorState(error: error)
            }).disposed(by: disposeBag)
    }
}
