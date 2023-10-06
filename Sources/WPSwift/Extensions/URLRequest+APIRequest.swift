//
//  File.swift
//  
//
//  Created by Ulaş Sancak on 1.10.2023.
//

import Foundation

extension URLRequest {
    init<RequestModel: Encodable, Response: Decodable>(_ baseURL: URL, request: APIRequest<RequestModel, Response>) throws {
        let url = baseURL.appendingPathComponent(request.endpoint.path)
        self = URLRequest(url: url)
        self.httpMethod = request.method.rawValue
        self.allHTTPHeaderFields = request.headers
        self.httpBody = try JSONEncoder().encode(request.requestModel)
    }
}
