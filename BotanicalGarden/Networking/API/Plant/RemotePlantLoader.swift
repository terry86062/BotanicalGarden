//
//  RemotePlantLoader.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public final class RemotePlantLoader: PlantLoader {

    private let loader: RemoteLoader

    public init(loader: RemoteLoader) {
        self.loader = loader
    }

    public func load(from request: PlantRequest?, completion: @escaping (PlantLoader.Result) -> Void) {
        guard let req = request else {
            completion(.failure(NetworkingError.Request.missingRequest))
            return
        }
        loader.load(from: req) { result in
            switch result {
            case let .success(response):
                completion(.success(response.result.results.toModels()))

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

private extension Array where Element == RemotePlantItem {
    func toModels() -> [PlantItem] {
        return map { PlantItem(name: $0.name, location: $0.location, feature: $0.feature, imageURL: URL(string: $0.imageLink)) }
    }
}
