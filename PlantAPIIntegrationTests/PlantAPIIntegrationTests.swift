//
//  PlantAPIIntegrationTests.swift
//  PlantAPIIntegrationTests
//
//  Created by 黃偉勛 Terry on 2021/4/20.
//

import XCTest
import BotanicalGarden

class PlantAPIIntegrationTests: XCTestCase {
    
    func test_endToEndTestServerGETPlantResult_matchesFixedPlantCount() {
        let client = URLSessionHTTPClient()
        let loader = BasicRemoteLoader(client: client)
        let plantLoader = RemotePlantLoader(loader: loader)
        
        let exp = expectation(description: "Wait for load completion")
        
        let request = PlantRequest(offset: 0)
        plantLoader.load(from: request) { result in
            switch result {
            case let .success(plant):
                XCTAssertEqual(plant.count, 20)
                
            case .failure(_):
                XCTFail("Expected successful plant count to 20, but failure")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5.0)
    }
}
