//
//  PlantViewModelTests.swift
//  BotanicalGardenTests
//
//  Created by 黃偉勛 on 2021/4/20.
//

import XCTest
import BotanicalGarden

class PlantViewModelTests: XCTestCase {

    func test_init_doesNotLoadPlantFromRequest() {
        let (_, loader) = makeSUT()
        XCTAssertTrue(loader.requestedRequests.isEmpty)
    }

    // MARK: - Helpers
    private func makeSUT() -> (sut: PlantViewModel, loader: PlantLoaderSpy) {
        let loader = PlantLoaderSpy()
        let sut = PlantViewModel(loader: loader)
        return (sut, loader)
    }

    private class PlantLoaderSpy: PlantLoader {
        private var messages = [(request: PlantRequest?, completion: (PlantLoader.Result) -> Void)]()

        var requestedRequests: [PlantRequest?] {
            return messages.map { $0.request }
        }

        func load(from request: PlantRequest?, completion: @escaping (PlantLoader.Result) -> Void) {
            messages.append((request, completion))
        }
    }
}
