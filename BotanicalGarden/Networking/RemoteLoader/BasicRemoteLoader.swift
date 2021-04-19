//
//  BasicRemoteLoader.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public final class BasicRemoteLoader: RemoteLoader {
    private let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }

    func load<Req: Request>(
        from request: Req,
        completion: @escaping (Result<Req.Mapper.Response, Error>) -> Void
    ) {
        let urlRequest: URLRequest
        do {
            urlRequest = try request.buildRequest()
        } catch {
            completion(.failure(error))
            return
        }
        
        client.get(from: urlRequest) { result in
            switch result {
            case let .success((data, response)):
                do {
                    let item = try Req.Mapper.map(data, from: response)
                    completion(.success(item))
                } catch {
                    completion(.failure(error))
                }

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
