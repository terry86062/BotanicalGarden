//
//  PlantUIComposer.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

final class PlantUIComposer {
    
    static func plantComposedWith(loader: RemoteLoader) -> PlantViewController {
        let plantLoader = RemotePlantLoader(loader: loader)
        let vm = PlantViewModel(loader: plantLoader)
        let vc = PlantViewController(viewModel: vm)
        return vc
    }
}
