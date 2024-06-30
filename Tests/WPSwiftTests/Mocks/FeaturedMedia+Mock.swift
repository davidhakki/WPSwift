//
//  FeaturedMedia+Mock.swift
//
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation
@testable import WPSwift

extension FeaturedMedia {
    static var mock: FeaturedMedia {
        .init(
            id: 123,
            title: .init(rendered: "Featured Media Title"),
            caption: .init(rendered: "<p>Featured Media Caption</p>"),
            altText: "Featured Media Alt Text",
            mediaDetails: .init(
                width: 1024,
                height: 684,
                sizes: [
                    "thumbnail": .init(
                        width: 150,
                        height: 150,
                        sourceURL: "https://example.com/wp-content/uploads/2024/06/7D5B29B3-CCFC-4E56-B838-81B48EBE9C24.jpg?quality=85&w=150&h=150&crop=1"
                    )
                ]
            ),
            sourceURL: "https://example.com/wp-content/uploads/2024/06/7D5B29B3-CCFC-4E56-B838-81B48EBE9C24.jpg?quality=85"
        )
    }
}
