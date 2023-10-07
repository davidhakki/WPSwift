//
//  AnyCodable+Mock.swift
//  
//
//  Created by Ulaş Sancak on 7.10.2023.
//

import Foundation
@testable import WPSwift

extension AnyCodable {
    static var mockData: Data {
        get throws {
            guard let url = Bundle.module.url(forResource: "Any", withExtension: "json") else {
                throw MockError.fileNotFound("Any.json")
            }
            let data = try Data(contentsOf: url)
            return data
        }
    }
    static var mockFromData: [String: AnyCodable] {
        get throws {
            let data = try mockData
            let decoder = JSONDecoder.initialize()
            let mock = try decoder.decode([String: AnyCodable].self, from: data)
            return mock
        }
    }
    static var mock: [String: AnyCodable] {
        [
            "double_key": .double(1234.5),
            "string_key": .string("string"),
            "bool_key": .bool(true)
        ]
    }
}
