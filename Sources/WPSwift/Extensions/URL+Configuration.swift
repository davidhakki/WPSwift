//
//  URL+Configuration.swift
//
//
//  Created by Ulaş Sancak on 1.10.2023.
//

import Foundation

@available(macOS 13.0, *)
extension String {
    static func initialize(with endpoint: String) throws -> String {
        let configuration = try WPSwift.configuration
        guard var url = URL(string: configuration.route) else {
            throw NetworkError.urlMalformed
        }
        url.append(path: configuration.namespace)
        url.append(path: endpoint)
        return url.absoluteString
    }
}
