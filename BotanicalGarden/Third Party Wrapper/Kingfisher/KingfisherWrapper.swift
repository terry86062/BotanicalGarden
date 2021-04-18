//
//  KingfisherWrapper.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with url: URL?) {
        kf.setImage(with: url)
    }
    
    func cancelDownloadTask() {
        kf.cancelDownloadTask()
    }
}
