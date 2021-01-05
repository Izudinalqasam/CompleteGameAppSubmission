//
//  Interactor.swift
//  Core
//
//  Created by izzudin on 04/01/21.
//

import Foundation
import RxSwift

public struct Interactor<Request, Response, R: Repository> : UseCase
where R.Response == Response, R.Request == Request {
    
    private let _repository: R
    
    public init(repository: R) {
        self._repository = repository
    }
    
    public func execute(request: Request?) -> Observable<Response> {
        return _repository.execute(request: request)
    }
}
