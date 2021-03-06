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
        
        let request = PlantRequest()
        sut.load(from: request) { _ in }
        
        let urlRequest = try! request.buildRequest()
        
        XCTAssertEqual(client.requestedURLRequests, [urlRequest])
    }
    
    func test_loadTwice_requestsDataFromURLRequestTwice() {
        let (sut, client) = makeSUT()
        
        let request = PlantRequest()
        sut.load(from: request) { _ in }
        sut.load(from: request) { _ in }
        
        let urlRequest = try! request.buildRequest()
        
        XCTAssertEqual(client.requestedURLRequests, [urlRequest, urlRequest])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        let clientError = NSError(domain: "Test", code: 0)
        
        let request = PlantRequest()
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
            
            let request = PlantRequest()
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
    
    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()

        let item = RemotePlantItem(name: "", location: "", feature: "", imageLink: "")
        let json = [
            "F_Name_Ch": "",
            "F_Location": "",
            "F_Feature": "",
            "F_Pic01_URL": ""
        ]

        let request = PlantRequest()
        sut.load(from: request) { result in
            switch result {
            case let .success(resultItem):
                XCTAssertEqual(resultItem.result.results, [item])

            case .failure(_):
                XCTFail("Expected success with \([item]), but failure")
            }
        }

        let jsonData = makeItemsJSON([json])
        client.complete(withStatusCode: 200, data: jsonData)
    }

    // MARK: - Helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: BasicRemoteLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = BasicRemoteLoader(client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
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

    private struct PlantRequest: Request {
        typealias Mapper = BasicResponseMapper<Root<[RemotePlantItem]>>

        let urlStr = "https://data.taipei/api/v1/dataset/f18de02f-b6c9-47c0-8cda-50efad621c14"
        let method = HTTPMethod.get
        var parameters: [String: Any] { return ["scope": "resourceAquire"] }
    }
}
