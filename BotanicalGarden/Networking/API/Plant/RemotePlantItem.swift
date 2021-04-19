//
//  RemotePlantItem.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public struct RemotePlantItem: Decodable, Equatable {
    let name: String
    let location: String
    let feature: String
    let imageLink: String

    enum CodingKeys: String, CodingKey {
        case name = "F_Name_Ch"
        case location = "F_Location"
        case feature = "F_Feature"
        case imageLink = "F_Pic01_URL"
    }
    
    public init(name: String, location: String, feature: String, imageLink: String) {
        self.name = name
        self.location = location
        self.feature = feature
        self.imageLink = imageLink
    }
}
