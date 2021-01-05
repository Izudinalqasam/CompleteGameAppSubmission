//
//  RemoteDataSource.swift
//  Submission1GameApp
//
//  Created by izzudin on 16/10/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import Core

public protocol RemoteDataSourceProtocol {
    func getListItem() -> Observable<[GameItemResponse]>
    func searchGame(query: String) -> Observable<[GameItemResponse]>
    func getDetailGame(idGame: String) -> Observable<GameItemDetailResponse>
}

public class RemoteDataSource: RemoteDataSourceProtocol {
    private let decoder = JSONDecoder()
    var urlComponent = API.gameEndpoint
    
    public init() {}
    
    public func getListItem() -> Observable<[GameItemResponse]> {
        urlComponent.queryItems = [
            URLQueryItem(name: "page_size", value: "10")
        ]
        
        return Observable.create { (observer) -> Disposable in
            if let url = self.urlComponent.url {
                AF.request(url).validate().responseDecodable(of: GameResult.self) { (response) in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data.results)
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            } else {
                observer.onError(URLError.addressUnreachable(self.urlComponent.url))
            }
            
            return Disposables.create()
        }
       
    }
    
    public func searchGame(query: String) -> Observable<[GameItemResponse]> {
        urlComponent.queryItems = [
            URLQueryItem(name: "search", value: query)
        ]
        
        return Observable.create { (observer) -> Disposable in
            if let url = self.urlComponent.url {
                AF.request(url).validate().responseDecodable(of: GameResult.self) { (response) in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data.results)
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            } else {
                observer.onError(URLError.addressUnreachable(self.urlComponent.url))
            }
            
            return Disposables.create()
        }
    }
    
    public func getDetailGame(idGame: String) -> Observable<GameItemDetailResponse> {
        urlComponent.path += "/\(idGame)"
        
        return Observable.create { (observer) -> Disposable in
            if let url = self.urlComponent.url {
                AF.request(url).validate().responseDecodable(of: GameItemDetailResponse.self) { (response) in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            } else {
                observer.onError(URLError.addressUnreachable(self.urlComponent.url))
            }
            
            return Disposables.create()
        }
    }
}
