//
//  URLQueryDataAdapter.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

struct URLQueryDataAdapter: RequestAdapter {
    let parameters: [String: Any]

    func adapted(request: URLRequest) throws -> URLRequest {
        guard let url = request.url else {
            throw NetworkingError.Request.missingURL
        }

        var req = request
        let finalURL = encoded(url: url)
        req.url = finalURL

        return req
    }

    func encoded(url: URL) -> URL {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return url }
        components.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value as? String)
        }
        return components.url ?? url
    }
}
