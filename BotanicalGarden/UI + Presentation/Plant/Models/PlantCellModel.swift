//
//  PlantCellModel.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import UIKit

struct PlantCellModel {
    let name: String
    let location: String
    let feature: String
    let imageURL: URL?
    
    let height: CGFloat
}

struct PlantCellModelsMapper {
    
    static func map(_ items: [PlantItem]) -> [PlantCellModel] {
        return items.map {
            let width = UIScreen.width - 16 - 64 - 16 - 16 // 64 為 image view 寬，16 為間距
            var height = $0.name.getHeight(with: width, font: UIFont.systemFont(ofSize: 14))
            height += $0.location.getHeight(with: width, font: UIFont.systemFont(ofSize: 12))
            height += $0.feature.getHeight(with: width, font: UIFont.systemFont(ofSize: 12))
            height += 4 + 28 // 4 為 label 間距，28 為 label stack 到上下距離
            return PlantCellModel(name: $0.name, location: $0.location, feature: $0.feature, imageURL: $0.imageURL, height: height)
        }
    }
}
