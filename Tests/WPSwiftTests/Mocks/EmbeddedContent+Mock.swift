//
//  EmbeddedContent+Mock.swift
//
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation
@testable import WPSwift

extension EmbeddedContent {
    static var mock: EmbeddedContent {
        .init(
            author: .mock,
            featuredMedia: .mock,
            tags: [
                .init(
                    id: 1,
                    link: "https://example.com/some-category",
                    name: "Some Category",
                    taxonomy: .category
                )
            ],
            categories: [
                .init(
                    id: 2,
                    link: "https://example.com/some-tag",
                    name: "Some Tag",
                    taxonomy: .tag
                )
            ]
        )
    }
}

