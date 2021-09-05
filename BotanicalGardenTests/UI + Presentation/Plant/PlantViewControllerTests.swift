//
//  PlantViewControllerTests.swift
//  BotanicalGardenTests
//
//  Created by 黃偉勛 on 2021/4/20.
//

import XCTest
import BotanicalGarden

class PlantViewControllerTests: XCTestCase {

    func test_loadPlantActions_requestPlantFromViewModel() {
        let vm = PlantViewModelSpy()
        let sut = PlantViewController(viewModel: (vm.inputs, vm.outputs))

        XCTAssertEqual(vm.loadPlantCallCount, 0)

        sut.loadViewIfNeeded()
        XCTAssertEqual(vm.loadPlantCallCount, 1)
    }
    
    // MARK: - Helpers
    private class PlantViewModelSpy: ViewModel, PlantViewModelInputs, PlantViewModelOutputs {
        var inputs: PlantViewModelInputs { return self }
        var outputs: PlantViewModelOutputs { return self }

        var items: [PlantCellModel] = []
        var didLoadPlant: (([IndexPath]) -> Void)?

        func loadPlant() {
            loadPlantCallCount += 1
        }

        var loadPlantCallCount = 0
    }
}
