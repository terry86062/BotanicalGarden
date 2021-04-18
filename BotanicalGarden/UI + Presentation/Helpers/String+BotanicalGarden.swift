//
//  String+BotanicalGarden.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import UIKit

extension String {
    func getHeight(with width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(
            width: width,
            height: .greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil)
        
        return ceil(boundingBox.height)
    }
}
