//
//  HTTPClient.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    func get(from request: URLRequest, completion: @escaping (Result) -> Void)
}
