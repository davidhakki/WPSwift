//
//  Category.swift
//
//
//  Created by Ulaş Sancak on 1.07.2024.
//

import Foundation

public struct PostCategory: Decodable, Sendable {
    public let id: Int
    public let count: Int
    public let description: String
    public let link: String
    public let name: String
    public let parent: Int
    
    public init(id: Int, count: Int, description: String, link: String, name: String, parent: Int) {
        self.id = id
        self.count = count
        self.description = description
        self.link = link
        self.name = name
        self.parent = parent
    }
}

public struct PostCategoryToCreate: Encodable, Sendable {
    public let description: String
    public let name: String
    public let parent: Int
    
    public init(description: String, name: String, parent: Int) {
        self.description = description
        self.name = name
        self.parent = parent
    }
}

public struct PostCategoryToUpdate: Encodable, Sendable {
    public let id: Int
    public let description: String
    public let name: String
    public let parent: Int
    
    public init(id: Int, description: String, name: String, parent: Int) {
        self.id = id
        self.description = description
        self.name = name
        self.parent = parent
    }
}
