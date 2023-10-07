//
//  AnyCodable.swift
//  
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation

// Because the WordPress API can return meta data with different value types,
// we can use the following general-purpose Codable struct:
struct AnyCodable: Codable {
    let value: Codable

    init<T: Codable>(_ value: T) {
        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let intVal = try? container.decode(Int.self) {
            value = intVal
            return
        }
        if let stringVal = try? container.decode(String.self) {
            value = stringVal
            return
        }
        if let boolVal = try? container.decode(Bool.self) {
            value = boolVal
            return
        }
        if let doubleVal = try? container.decode(Double.self) {
            value = doubleVal
            return
        }

        throw DecodingError.dataCorruptedError(in: container,
                                               debugDescription: "Cannot decode value")
    }
}
