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
    
    func test_loadTwice_requestsDataFromURLRequestTwice() {
        let (sut, client) = makeSUT()
        
        let request = PlantRequest(offset: 0)
        sut.load(from: request) { _ in }
        sut.load(from: request) { _ in }
        
        let urlRequest = try! request.buildRequest()
        
        XCTAssertEqual(client.requestedURLRequests, [urlRequest, urlRequest])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        let clientError = NSError(domain: "Test", code: 0)
        
        let request = PlantRequest(offset: 0)
        sut.load(from: request) { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure with \(clientError), but success")
                
            case let .failure(error):
                XCTAssertEqual(error as NSError, clientError)
            }
        }
        
        client.complete(with: clientError)
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            
            let request = PlantRequest(offset: 0)
            sut.load(from: request) { result in
                switch result {
                case .success(_):
                    XCTFail("Expected failure with \(NetworkingError.Response.invalidData), but success")
                    
                case let .failure(error):
                    XCTAssertEqual(error as! NetworkingError.Response, NetworkingError.Response.invalidData)
                }
            }
            
            let json = makeItemsJSON([])
            client.complete(withStatusCode: code, data: json, at: index)
        }
    }

    // MARK: - Helpers
    private func makeSUT() -> (sut: BasicRemoteLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = BasicRemoteLoader(client: client)
        return (sut, client)
    }
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let json = [
            "result": [
                "results": items
            ]
        ]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(urlRequest: URLRequest, completion: (HTTPClient.Result) -> Void)]()

        var requestedURLRequests: [URLRequest] {
            return messages.map { $0.urlRequest }
        }
        
        func get(from request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) {
            messages.append((request, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLRequests[index].url!,
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            messages[index].completion(.success((data, response)))
        }
    }
}
