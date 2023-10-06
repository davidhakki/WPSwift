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

    var errorDescription: String? {
        switch self {
        case .urlMalformed:
            "URL is malformed."
        case .api:
            "API returned an unexpected response."
        }
    }
}

@available(macOS 14.0, *)
struct NetworkManager {
    private let baseURL: URL

    init() throws {
        self.baseURL = try URL.initializeWithConfiguration()
    }

    func request<RequestModel: Encodable, Response: Decodable>(_ request: APIRequest<RequestModel, Response>) async throws -> Response {
        let request = try URLRequest(baseURL, request: request)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.api
        }

        return try JSONDecoder().decode(Response.self, from: data)
    }
}

@available(macOS 14.0, *)
extension NetworkManager {
    func request<RequestModel: Encodable, Response: Decodable>(_ request: APIRequest<RequestModel, Response>) -> AnyPublisher<Response, Error> {
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
                .decode(type: Response.self, decoder: JSONDecoder())

            return publisher.eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
