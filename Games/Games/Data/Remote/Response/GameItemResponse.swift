//
//  GameItem.swift
//  Submission1GameApp
//
//  Created by izzudin on 01/08/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

public struct GameItemResponse: Codable {
    public let idGame: Int
    public let name: String
    public let released: String?
    public let rating: Float?
    public let backgroundImage: String?
    
    enum CodingKeys: String, CodingKey {
        case idGame = "id"
        case backgroundImage = "background_image"
        case name, released, rating
    }
}
