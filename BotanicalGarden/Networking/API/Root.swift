//
//  Root.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

struct Root<T: Decodable>: Decodable {
    let result: Result

    struct Result: Decodable {
        let results: T
    }
}
