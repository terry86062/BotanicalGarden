//
//  PlantTableViewCell.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import UIKit

class PlantTableViewCell: UITableViewCell {

    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var featureLabel: UILabel!
    
    func configure(imageURL: URL?, name: String, location: String, feature: String) {
        nameLabel.text = name
        locationLabel.text = location
        featureLabel.text = feature
    }
}
