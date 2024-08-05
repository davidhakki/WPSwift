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
    public let htmlDecodedTitle: String

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case link = "url"
    }
    
    public init(id: Int, title: String, link: String) {
        self.id = id
        self.title = title
        self.link = link
        self.htmlDecodedTitle = title.decodedHTML
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        link = try container.decode(String.self, forKey: .link)
        htmlDecodedTitle = title.decodedHTML
    }
}
