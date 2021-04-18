//
//  PlantCellModel.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

struct PlantCellModel {
    let name: String
    let location: String
    let feature: String
    let imageURL: URL?
}

struct PlantCellModelsMapper {
    
    static func map(_ items: [PlantItem]) -> [PlantCellModel] {
        return items.map {
            PlantCellModel(
                name: $0.name,
                location: $0.location,
                feature: $0.feature,
                imageURL: $0.imageURL)
        }
    }
}
