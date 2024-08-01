//
//  URL+Configuration.swift
//
//
//  Created by Ulaş Sancak on 1.10.2023.
//

import Foundation

extension String {
    static func initialize(with endpointType: WPClientConfiguration.EndpointType) throws -> String {
        switch endpointType {
        case .base(let baseURL, let endpoint):
            guard var url = URL(string: baseURL) else {
                throw NetworkError.urlMalformed
            }
            url.append(path: endpoint)
            return url.absoluteString
        case .endpoint(let endpoint):
            let configuration = try WPSwift.configuration
            guard var url = URL(string: configuration.route) else {
                throw NetworkError.urlMalformed
            }
            url.append(path: configuration.namespace)
            url.append(path: endpoint)
            return url.absoluteString
        }
    }
    
    static func initializeRoute() throws -> String {
        let configuration = try WPSwift.configuration
        guard let url = URL(string: configuration.route) else {
            throw NetworkError.urlMalformed
        }
        return url.absoluteString
    }
}
