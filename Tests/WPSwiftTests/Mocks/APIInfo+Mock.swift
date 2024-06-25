//
//  APIInfo+Mock.swift
//
//
//  Created by Ulaş Sancak on 25.06.2023.
//

import Foundation
@testable import WPSwift

extension APIInfo {
    static var mockData: Data {
        get throws {
            guard let url = Bundle.module.url(forResource: "APIInfo", withExtension: "json") else {
                throw MockError.fileNotFound("APIInfo.json")
            }
            let data = try Data(contentsOf: url)
            return data
        }
    }
    static var mockFromData: APIInfo {
        get throws {
            let data = try mockData
            let decoder = JSONDecoder.initialize()
            let info = try decoder.decode(APIInfo.self, from: data)
            return info
        }
    }
    static var mock: APIInfo {
        .init(
            name: "Example",
            description: "Example site",
            url: "https://www.example.com",
            home: "https://www.example.com"
        )
    }
}
