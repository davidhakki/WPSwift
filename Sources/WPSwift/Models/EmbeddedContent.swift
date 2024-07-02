//
//  EmbeddedContent.swift
//
//
//  Created by Ulaş Sancak on 30.06.2024.
//

import Foundation

public struct EmbeddedContent: Decodable {
    public var author: Author? {
        _author?.first
    }
    public var featuredMedia: FeaturedMedia? {
        _featuredMedia?.first
    }
    public var tags: [Term] {
        guard let terms = terms.first else { return [] }
        return terms.filter { $0.taxonomy == .tag }
    }
    public var categories: [Term] {
        guard let terms = terms.first else { return [] }
        return terms.filter { $0.taxonomy == .category }
    }
    private let _author: [Author]?
    private let _featuredMedia: [FeaturedMedia]?
    private let terms: [[Term]]

    public init(author: Author? = nil, featuredMedia: FeaturedMedia? = nil, tags: [Term] = [], categories: [Term] = []) {
        _author = if let author {
            [author]
        } else {
            nil
        }
        _featuredMedia = if let featuredMedia {
            [featuredMedia]
        } else {
            nil
        }
        var terms: [Term] = []
        terms.append(contentsOf: tags)
        terms.append(contentsOf: categories)
        self.terms = [terms]
    }
    
    private enum CodingKeys: String, CodingKey {
        case _author = "author"
        case _featuredMedia = "wp:featuredmedia"
        case terms = "wp:term"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._author = try? container.decodeIfPresent([Author].self, forKey: ._author)
        self._featuredMedia = try? container.decodeIfPresent([FeaturedMedia].self, forKey: ._featuredMedia)
        self.terms = try container.decode([[Term]].self, forKey: .terms)
    }
}
