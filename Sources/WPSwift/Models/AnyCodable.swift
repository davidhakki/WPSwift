//
//  AnyCodable.swift
//  
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation

// Because the WordPress API can return meta data with different value types,
// we can use the following general-purpose Codable struct:
enum AnyCodable: Codable {
    case double(Double)
    case string(String)
    case bool(Bool)

    func encode(to encoder: Encoder) throws {
        switch self {
        case .double(let double):
            try double.encode(to: encoder)
        case .string(let string):
            try string.encode(to: encoder)
        case .bool(let bool):
            try bool.encode(to: encoder)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let doubleVal = try? container.decode(Double.self) {
            self = .double(doubleVal)
            return
        }
        if let stringVal = try? container.decode(String.self) {
            self = .string(stringVal)
            return
        }
        if let boolVal = try? container.decode(Bool.self) {
            self = .bool(boolVal)
            return
        }

        throw DecodingError.dataCorruptedError(in: container,
                                               debugDescription: "Cannot decode value")
    }
}
