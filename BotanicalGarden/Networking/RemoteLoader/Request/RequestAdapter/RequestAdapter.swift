//
//  RequestAdapter.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public protocol RequestAdapter {
    func adapted(request: URLRequest) throws -> URLRequest
}
