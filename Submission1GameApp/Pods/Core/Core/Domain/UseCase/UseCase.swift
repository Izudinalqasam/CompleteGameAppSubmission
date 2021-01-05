//
//  UseCase.swift
//  Core
//
//  Created by izzudin on 04/01/21.
//

import Foundation
import RxSwift

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}
