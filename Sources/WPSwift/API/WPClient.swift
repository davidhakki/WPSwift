//
//  APIClient.swift
//
//
//  Created by Ulaş Sancak on 1.10.2023.
//

import Foundation
import Combine
import Resting

enum NetworkError: LocalizedError {
    case urlMalformed
    case api(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .urlMalformed:
            "URL is malformed."
        case .api(let error):
            error.localizedDescription
        case .unknown:
            "Unknown error."
        }
    }
}

//extension NetworkError: Equatable {
//    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
//        switch (lhs, rhs) {
//        case (.urlMalformed, .urlMalformed):
//            return true
//        case (.api(let errorLeft), .api(let errorRight)):
//            return errorLeft.code == errorRight.code
//        case (.unknown, .unknown):
//            return true
//        default:
//            return false
//        }
//    }
//}

public struct WPClient<RequestModel: Encodable, Response: Decodable> {
    private let restClient: RestClient
    private let requestConfig: RequestConfiguration

    init(_ configuration: WPClientConfiguration) throws {
        restClient = RestClient.initialize()
        switch configuration.parameterType {
        case .object(let dictionary):
            requestConfig = RequestConfiguration(
                urlString: try .initialize(with: configuration.endpoint),
                method: configuration.method,
                parameters: dictionary,
                headers: configuration.headers, encoding: configuration.encoding
            )
        case .model(let encodable):
            requestConfig = RequestConfiguration(
                urlString: try .initialize(with: configuration.endpoint),
                method: configuration.method,
                body: try JSONEncoder.initialize().encode(encodable),
                headers: configuration.headers, encoding: configuration.encoding
            )
        case .none:
            requestConfig = RequestConfiguration(
                urlString: try .initialize(with: configuration.endpoint),
                method: configuration.method,
                headers: configuration.headers, encoding: configuration.encoding
            )
            break
        }
    }

    func fetch() async throws -> Response {
        do {
            return try await restClient.fetch(with: requestConfig)
        } catch {
            throw NetworkError.api(error)
        }
    }
}

extension WPClient {
    func fetchPublisher() -> AnyPublisher<Response, NetworkError> {
        restClient.publisher(with: requestConfig)
            .mapError {
                NetworkError.api($0)
            }.eraseToAnyPublisher()
    }
}
