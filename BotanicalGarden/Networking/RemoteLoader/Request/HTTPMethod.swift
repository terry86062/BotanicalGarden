//
//  HTTPMethod.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

extension HTTPMethod: RequestAdapter {
    
    public func adapted(request: URLRequest) throws -> URLRequest {
        var req = request
        req.httpMethod = self.rawValue
        return req
    }
}
