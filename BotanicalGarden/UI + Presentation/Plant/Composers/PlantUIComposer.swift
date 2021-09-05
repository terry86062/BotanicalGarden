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
        let vm = PlantViewModel(loader: MainQueueDispatchDecorator(decoratee: plantLoader))
        let vc = PlantViewController(viewModel: (vm.inputs, vm.outputs))
        return vc
    }
}

extension MainQueueDispatchDecorator: PlantLoader where T == PlantLoader {
    func load(from request: PlantRequest?, completion: @escaping (PlantLoader.Result) -> Void) {
        decoratee.load(from: request) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
