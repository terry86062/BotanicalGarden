//
//  PlantViewModel.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public protocol PlantViewModelInputs {
    func loadPlant()
}

public protocol PlantViewModelOutputs {
    var items: [PlantCellModel] { get }
    var didLoadPlant: (([IndexPath]) -> Void)? { get set }
}

public final class PlantViewModel: ViewModel, PlantViewModelInputs, PlantViewModelOutputs {
    
    private let loader: PlantLoader

    public init(loader: PlantLoader) {
        self.loader = loader
    }
    
    public var inputs: PlantViewModelInputs { return self }
    public var outputs: PlantViewModelOutputs { return self }
    
    // MARK: - outputs
    public var items: [PlantCellModel] = []
    public var didLoadPlant: (([IndexPath]) -> Void)?

    // MARK: - inputs
    public func loadPlant() {
        guard !isLoading else { return }
        isLoading = true
        
        let request = PlantRequest(offset: items.count)
        loader.load(from: request) { [weak self] result in
            guard let self = self else { return }
            if let plant = try? result.get() {
                self.didLoadPlantSuccess(with: plant)
            }
            self.isLoading = false
        }
    }
    
    // MARK: - Helpers
    private var isLoading = false
    
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
