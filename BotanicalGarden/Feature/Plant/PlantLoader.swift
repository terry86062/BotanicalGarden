//
//  PlantLoader.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public protocol PlantLoader {
    typealias Result = Swift.Result<[PlantItem], Error>
    
    func load(from request: PlantRequest?, completion: @escaping (Result) -> Void)
}
