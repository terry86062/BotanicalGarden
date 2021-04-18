//
//  Request.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

protocol Request {
    
    var url: URL { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    
    var adapters: [RequestAdapter] { get }
}

extension Request {

    var adapters: [RequestAdapter] {
        return [
            method
        ]
    }
    
    func buildRequest() throws -> URLRequest {
        let request = URLRequest(url: url)
        return try adapters.reduce(request) { try $1.adapted(request: $0) }
    }
}
