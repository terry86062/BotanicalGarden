//
//  NetworkingError.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

enum NetworkingError {

    enum Request: Error {
        case missingURL
    }
}