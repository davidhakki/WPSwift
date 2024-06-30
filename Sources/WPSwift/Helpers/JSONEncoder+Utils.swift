//
//  JSONEncoder+Utils.swift
//
//
//  Created by Ulaş Sancak on 7.10.2023.
//

import Foundation

extension JSONEncoder {
    static func initialize() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.default)
        return encoder
    }
}
