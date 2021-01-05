//
//  Repository.swift
//  Core
//
//  Created by izzudin on 04/01/21.
//

import Foundation
import RxSwift

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}
