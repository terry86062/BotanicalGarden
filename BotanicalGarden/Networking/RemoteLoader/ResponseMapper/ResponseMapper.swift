//
//  ResponseMapper.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

protocol ResponseMapper {
    associatedtype Response: Decodable

    static func map(_ data: Data, from response: HTTPURLResponse) throws -> Response
}
