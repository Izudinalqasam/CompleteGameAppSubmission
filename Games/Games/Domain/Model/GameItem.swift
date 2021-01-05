//
//  GameItem.swift
//  Submission1GameApp
//
//  Created by izzudin on 22/11/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation

public struct GameItem {
    public let idGame: Int
    public let name: String
    public let released: String
    public let rating: Float
    public let backgroundImage: String
    
    public init(idGame: Int, name: String, released: String, rating: Float, backgroundImage: String) {
        self.idGame = idGame
        self.name = name
        self.released = released
        self.rating = rating
        self.backgroundImage = backgroundImage
    }
}
