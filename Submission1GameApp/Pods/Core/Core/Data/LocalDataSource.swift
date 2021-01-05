//
//  LocalDataSource.swift
//  Core
//
//  Created by izzudin on 04/01/21.
//

import RxSwift

public protocol LocalDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(by: Request?) -> Observable<[Response]>
    func add(by game: Response) -> Completable
    func get(by game: Request) -> Observable<Response>
    func delete(by game: Request) -> Completable
}
