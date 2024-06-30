//
//  EmbeddedContent.swift
//
//
//  Created by Ulaş Sancak on 30.06.2024.
//

import Foundation

public struct EmbeddedContent: Decodable {
    public var author: Author? {
        _author.first
    }
    public var featuredMedia: FeaturedMedia? {
        _featuredMedia.first
    }
    private let _author: [Author]
    private let _featuredMedia: [FeaturedMedia]
    
    public init(author: Author? = nil, featuredMedia: FeaturedMedia? = nil) {
        _author = if let author {
            [author]
        } else {
            []
        }
        _featuredMedia = if let featuredMedia {
            [featuredMedia]
        } else {
            []
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case _author = "author"
        case _featuredMedia = "wp:featuredmedia"
    }
}
