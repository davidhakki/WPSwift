//
//  APIClient.swift
//
//
//  Created by Ulaş Sancak on 1.10.2023.
//

import Foundation
import Combine

enum NetworkError: LocalizedError {
    case urlMalformed
    case api
    case unknown

    var errorDescription: String? {
        switch self {
        case .urlMalformed:
            "URL is malformed."
        case .api:
            "API returned an unexpected response."
        case .unknown:
            "Unknown error."
        }
    }
}

@available(macOS 14.0, *)
public struct APIClient<RequestModel: Encodable, Response: Decodable> {
    private let baseURL: URL
    private let request: APIRequest<RequestModel, Response>

    init(_ request: APIRequest<RequestModel, Response>) throws {
        self.request = request
        self.baseURL = try URL.initializeWithConfiguration()
    }

    func request() async throws -> Response {
        let request = try URLRequest(baseURL, request: request)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.api
        }

        return try JSONDecoder.initialize().decode(Response.self, from: data)
    }
}

@available(macOS 14.0, *)
extension APIClient {
    func requestPublisher() -> AnyPublisher<Response, Error> {
        do {
            let request = try URLRequest(baseURL, request: request)

            let publisher = URLSession.shared.dataTaskPublisher(for: request)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                          200..<300 ~= httpResponse.statusCode else {
                        throw NetworkError.api
                    }
                    return element.data
                }
                .decode(type: Response.self, decoder: JSONDecoder.initialize())

            return publisher.eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
