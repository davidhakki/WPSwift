//
//  APIInfoRepository.swift
//
//
//  Created by Ulaş Sancak on 25.06.2024.
//

import Foundation
import Resting

public struct APIInfoRepository: Sendable {
    public init() {}

    public func getAPIInfo(route: String? = nil) async throws -> APIInfo {
        let urlString = if let route {
            route
        } else {
            try String.initializeRoute()
        }
        let restClient: RestClient  = .initialize()
        let info: APIInfo = try await restClient.fetch(with: .init(urlString: urlString, method: .get))
        return info
    }
}
