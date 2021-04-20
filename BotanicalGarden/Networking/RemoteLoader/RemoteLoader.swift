//
//  RemoteLoader.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public protocol RemoteLoader {
    func load<Req: Request>(
        from request: Req,
        completion: @escaping (Result<Req.Mapper.Response, Error>) -> Void
    )
}
