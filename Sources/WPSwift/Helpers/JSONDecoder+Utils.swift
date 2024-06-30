//
//  File.swift
//  
//
//  Created by Ulaş Sancak on 7.10.2023.
//

import Foundation

extension JSONDecoder {
    static func initialize() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.default)
        return decoder
    }
}
