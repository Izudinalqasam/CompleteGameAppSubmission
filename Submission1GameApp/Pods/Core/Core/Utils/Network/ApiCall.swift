//
//  ApiCall.swift
//  Submission1GameApp
//
//  Created by izzudin on 21/11/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation

public struct API {

    public static var gameEndpoint: URLComponents {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.rawg.io"
        urlComponent.path = "/api/games"
        return urlComponent
    }
}

public protocol EndPoint {
    var url: String { get }
}
