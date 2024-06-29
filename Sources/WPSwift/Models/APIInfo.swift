//
//  APIInfo.swift
//
//
//  Created by Ulaş Sancak on 25.06.2024.
//

import Foundation

public struct APIInfo: Decodable {
    public let name: String
    public let description: String?
    public let url: String?
    public let home: String?
    
    public init(name: String, description: String? = nil, url: String? = nil, home: String? = nil) {
        self.name = name
        self.description = description
        self.url = url
        self.home = home
    }
}
