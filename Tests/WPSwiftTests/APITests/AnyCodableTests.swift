//
//  AnyCodableTests.swift
//  
//
//  Created by Ulaş Sancak on 7.10.2023.
//

import XCTest
@testable import WPSwift

final class AnyCodableTests: XCTestCase {
    func testSuccess() throws {
        let mockFromData = try AnyCodable.mockFromData
        let mock = AnyCodable.mock

        _ = try JSONEncoder.initialize().encode(mock)

        mockFromData.forEach({
            let anyCodable = mock[$0.key]
            switch $0.value {
            case .double(let double):
                if case .double(let double2) = anyCodable {
                    XCTAssertEqual(double, double2)
                } else {
                    XCTAssert(false)
                }
            case .string(let string):
                if case .string(let string2) = anyCodable {
                    XCTAssertEqual(string, string2)
                } else {
                    XCTAssert(false)
                }
            case .bool(let bool):
                if case .bool(let bool2) = anyCodable {
                    XCTAssertEqual(bool, bool2)
                } else {
                    XCTAssert(false)
                }
            }
        })
    }

    func testFailure() {
        let exampleString = "{\"title\":\"Title\"}"
        let exampleData = exampleString.data(using: .utf8)!
        let decoder = JSONDecoder.initialize()
        do {
            _ = try decoder.decode(AnyCodable.self, from: exampleData)
        } catch DecodingError.dataCorrupted {
        } catch {
            XCTAssert(false, "Test should be failed with DecodingError.dataCorrupted!")
        }
    }
}
