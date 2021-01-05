//
//  GetListPresenter.swift
//  Core
//
//  Created by izzudin on 05/01/21.
//

import Foundation
import RxSwift

public protocol GetListPresenterContractView {
    associatedtype Result
    
    func onGetResult(result: Result)
}

public class GetListPresenter<Request, Response, Interactor: UseCase,
    Contract: GetListPresenterContractView>
where Interactor.Request == Request, Interactor.Response == Response,
      Interactor.Response == Contract.Result {
    
    private let useCase: Interactor
    private let disposeBag = DisposeBag()
    public var listener: Contract?
    
    public init(useCase: Interactor) {
        self.useCase = useCase
    }
    
    public func getAllGame() {
        useCase.execute(request: nil)
            .observeOn(MainScheduler.instance)
            .subscribe { (result) in
                self.listener?.onGetResult(result: result)
            }.disposed(by: disposeBag)
    }
}
