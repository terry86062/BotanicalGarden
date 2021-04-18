//
//  RequestContentAdapter.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

struct RequestContentAdapter: RequestAdapter {
    let method: HTTPMethod
    let content: [String: Any]

    func adapted(request: URLRequest) throws -> URLRequest {
        switch method {
        case .get:
            return try URLQueryDataAdapter(parameters: content).adapted(request: request)
        }
    }
}
