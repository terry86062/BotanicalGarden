//
//  Root.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public struct Root<T: Decodable>: Decodable {
    public let result: Result

    public struct Result: Decodable {
        public let results: T
    }
}
