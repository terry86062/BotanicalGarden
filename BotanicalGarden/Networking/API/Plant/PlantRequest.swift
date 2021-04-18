//
//  PlantRequest.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

struct PlantRequest: Request {

    typealias Mapper = BasicResponseMapper<Root<[RemotePlantItem]>>

    let urlStr = "https://data.taipei/api/v1/dataset/f18de02f-b6c9-47c0-8cda-50efad621c14"
    let method = HTTPMethod.get

    var parameters: [String: Any] {
        return [
            "scope": "resourceAquire",
            "limit": "\(limit)",
            "offset": "\(offset)"
        ]
    }

    let limit: Int = 20
    let offset: Int
}
