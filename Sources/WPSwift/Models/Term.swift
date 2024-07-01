//
//  Term.swift
//
//
//  Created by Ulaş Sancak on 1.07.2024.
//

import Foundation

public enum TermType: String, Decodable {
    case category
    case tag = "post_tag"
    case unknown
}

public struct Term: Decodable {
    public let id: Int
    public let link: String
    public let name: String
    public let taxonomy: TermType
    
    public init(id: Int, link: String, name: String, taxonomy: TermType) {
        self.id = id
        self.link = link
        self.name = name
        self.taxonomy = taxonomy
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case link
        case name
        case taxonomy
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        link = try container.decode(String.self, forKey: .link)
        name = try container.decode(String.self, forKey: .name)
        let taxonomyString = try container.decode(String.self, forKey: .taxonomy)
        taxonomy = .init(rawValue: taxonomyString) ?? .unknown
    }
}
