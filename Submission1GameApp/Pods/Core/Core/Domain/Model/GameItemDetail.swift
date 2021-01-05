//
//  GameItemDetail.swift
//  Submission1GameApp
//
//  Created by izzudin on 22/11/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation

public struct GameItemDetail {
    public let idGame: Int
    public let name: String
    public let released: String
    public let rating: Float
    public let backgroundImage: String
    public let description: String
    
    public init(idGame: Int, name: String, released: String, rating: Float, backgroundImage: String, description: String) {
        self.idGame = idGame
        self.name = name
        self.released = released
        self.rating = rating
        self.backgroundImage = backgroundImage
        self.description = description
    }
}
