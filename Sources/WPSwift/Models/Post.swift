//
//  SimplePost.swift
//
//
//  Created by Ulaş Sancak on 5.07.2023.
//

import Foundation

public struct SimplePost: Decodable {
    public let id: Int
    public let title: String
    public let link: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case link = "url"
    }
    
    public init(id: Int, title: String, link: String) {
        self.id = id
        self.title = title
        self.link = link
    }
}
