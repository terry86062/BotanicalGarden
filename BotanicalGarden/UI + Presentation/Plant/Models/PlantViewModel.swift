//
//  PlantViewModel.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

protocol PlantViewModelInputs {
    func loadPlant()
}

protocol PlantViewModelOutputs {
    var items: [PlantCellModel] { get }
    var didLoadPlant: (([IndexPath]) -> Void)? { get set }
}

final class PlantViewModel: ViewModel, PlantViewModelInputs, PlantViewModelOutputs {
    
    private let loader: PlantLoader

    init(loader: PlantLoader) {
        self.loader = loader
    }
    
    var inputs: PlantViewModelInputs { return self }
    var outputs: PlantViewModelOutputs { return self }
    
    // MARK: - outputs
    var items: [PlantCellModel] = []
    var didLoadPlant: (([IndexPath]) -> Void)?

    // MARK: - inputs
    func loadPlant() {
        let request = PlantRequest(offset: items.count)
        loader.load(from: request) { [weak self] result in
            guard let self = self else { return }
            if let plant = try? result.get() {
                self.didLoadPlantSuccess(with: plant)
            }
        }
    }
    
    // MARK: - Helpers
    private func didLoadPlantSuccess(with plant: [PlantItem]) {
        let indexPaths = getIndexPaths(withNew: plant.count)
        items += PlantCellModelsMapper.map(plant)
        didLoadPlant?(indexPaths)
    }
    
    private func getIndexPaths(withNew plantCount: Int) -> [IndexPath] {
        let startIndex = self.items.count
        let endIndex = startIndex + plantCount
        return (startIndex..<endIndex).map { row in
            IndexPath(row: row, section: 0)
        }
    }
}
