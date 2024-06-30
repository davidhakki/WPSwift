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
            featuredMedia: .mock
        )
    }
}
