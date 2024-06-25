//
//  APIInfoRepositoryTests.swift
//
//
//  Created by Ulaş Sancak on 25.06.2024.
//

import XCTest
@testable import WPSwift

final class APIInfoRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        WPSwift.initialize(route: "https://www.example.com/wp-json", namespace: "wp/v2")
        WPSwift.sessionConfiguration.protocolClasses = [MockedURLProtocol.self]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        WPSwift.sessionConfiguration.protocolClasses = nil
    }

    func testCheckingAPI() async throws {
        MockedURLProtocol.observer = { request -> (URLResponse?, Data?) in
            let response = HTTPURLResponse(url: URL(string: "https://www.example.com/wp-json")!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response, try APIInfo.mockData)
        }
        
        let repository = APIInfoRepository()
        let infoFromData = try await repository.getAPIInfo()

        let info: APIInfo = .mock
        
        XCTAssertEqual(info.name, infoFromData.name)
        XCTAssertEqual(info.description, infoFromData.description)
        XCTAssertEqual(info.url, infoFromData.url)
        XCTAssertEqual(info.home, infoFromData.home)
    }
}
