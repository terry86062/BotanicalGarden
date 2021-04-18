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
}
