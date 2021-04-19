//
//  NetworkingError.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public enum NetworkingError {

    enum Request: Error {
        case missingRequest
        case invalidURL
        case missingURL
    }
    
    public enum Response: Error {
        case invalidData
    }
}
