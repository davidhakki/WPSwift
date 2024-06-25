//
//  APIInfoRepository.swift
//
//
//  Created by Ulaş Sancak on 25.06.2024.
//

import Foundation
import Resting

public struct APIInfoRepository {
    public func getAPIInfo() async throws -> APIInfo {
        let restClient: RestClient  = .initialize()
        let info: APIInfo = try await restClient.fetch(with: .init(urlString: .initializeRoute(), method: .get))
        return info
    }
}
