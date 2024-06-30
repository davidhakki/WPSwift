//
//  Author.swift
//  
//
//  Created by Ulaş Sancak on 30.06.2024.
//

import Foundation

public struct Author: Decodable {
    public let id: Int
    public let name: String
    public let description: String
    
    public init(id: Int, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
