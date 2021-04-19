//
//  Request.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public protocol Request {
    
    associatedtype Mapper: ResponseMapper
    
    var urlStr: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    
    var adapters: [RequestAdapter] { get }
}

public extension Request {
    
    var url: URL? {
        URL(string: urlStr)
    }

    var adapters: [RequestAdapter] {
        return [
            method,
            RequestContentAdapter(method: method, content: parameters)
        ]
    }
    
    func buildRequest() throws -> URLRequest {
        guard let url = url else {
            throw NetworkingError.Request.invalidURL
        }
        let request = URLRequest(url: url)
        return try adapters.reduce(request) { try $1.adapted(request: $0) }
    }
}
