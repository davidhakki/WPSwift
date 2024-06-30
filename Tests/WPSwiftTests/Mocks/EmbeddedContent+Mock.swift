//
//  Author+Mock.swift
//
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation
@testable import WPSwift

extension Author {
    static var mock: Author {
        .init(
            id: 123,
            name: "Author Name",
            description: "Author Description"
        )
    }
}
