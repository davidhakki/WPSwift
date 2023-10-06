//
//  APIRequest.swift
//  
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation

typealias APIHeaders = [String: String]

struct APIHeaderKeys {
    static let contentType = "Content-Type"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    // ... other methods
}

enum APIEndpoint {
    case getPosts

    var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        }
    }
}

struct APIRequest<RequestModel: Encodable, Response: Decodable> {
    let endpoint: APIEndpoint
    let method: HTTPMethod
    var headers: APIHeaders
    var requestModel: RequestModel?

    init(endpoint: APIEndpoint, method: HTTPMethod, headers: [String : String]? = nil, requestModel: RequestModel? = EmptyModel()) {
        self.endpoint = endpoint
        self.method = method
        if var headers = headers {
            headers[APIHeaderKeys.contentType] =  "application/json"
            self.headers = headers
        } else {
            self.headers = [APIHeaderKeys.contentType: "application/json"]
        }
        self.requestModel = requestModel
    }
}
