//
//  BasicRemoteLoaderTests.swift
//  BotanicalGardenTests
//
//  Created by 黃偉勛 Terry on 2021/4/20.
//

import XCTest
import BotanicalGarden

class BasicRemoteLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURLRequest() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLRequests.isEmpty)
    }
    
    func test_load_requestsDataFromURLRequest() {
        let (sut, client) = makeSUT()
        
        let request = PlantRequest(offset: 0)
        sut.load(from: request) { _ in }
        
        let urlRequest = try! request.buildRequest()
        
        XCTAssertEqual(client.requestedURLRequests, [urlRequest])
    }

    // MARK: - Helpers
    private func makeSUT() -> (sut: BasicRemoteLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = BasicRemoteLoader(client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(urlRequest: URLRequest, completion: (HTTPClient.Result) -> Void)]()

        var requestedURLRequests: [URLRequest] {
            return messages.map { $0.urlRequest }
        }
        
        func get(from request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) {
            messages.append((request, completion))
        }
    }
}
