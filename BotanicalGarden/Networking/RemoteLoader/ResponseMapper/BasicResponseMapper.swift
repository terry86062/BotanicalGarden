//
//  BasicResponseMapper.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

final class BasicResponseMapper<Response: Decodable>: ResponseMapper {

    private static var OK_200: Int { return 200 }

    static func map(_ data: Data, from response: HTTPURLResponse) throws -> Response {
        guard response.statusCode == OK_200,
            let res = try? JSONDecoder().decode(Response.self, from: data) else {
            throw NetworkingError.Response.invalidData
        }
        return res
    }
}
