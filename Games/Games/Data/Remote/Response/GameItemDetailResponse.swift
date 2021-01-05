//
//  GameItemDetail.swift
//  Submission1GameApp
//
//  Created by izzudin on 02/08/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation

public struct GameItemDetailResponse: Codable {
    public let idGame: Int
    public let name: String
    public let released: String
    public let rating: Float
    public let backgroundImage: String
    public let description: String
    
    enum CodingKeys: String, CodingKey {
        case idGame = "id"
        case backgroundImage = "background_image"
        case description = "description_raw"
        case name, released, rating
    }
}
