//
//  CustomErrorExtention.swift
//  Submission1GameApp
//
//  Created by izzudin on 22/11/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation

public enum URLError: LocalizedError {
    case invalidResponse
    case addressUnreachable(URL?)
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server responded with gerbage."
        case .addressUnreachable(let url):
            return "\(url?.absoluteString ?? "") is unreachable"
        }
    }
}

public enum DatabaseError: LocalizedError {
    case invalidInstance
    case requestFailed
    
    public var errorDescription: String? {
        switch self {
        case .invalidInstance:
            return "Database can't instance."
        case .requestFailed:
            return "Your request failed"
        }
    }
}
