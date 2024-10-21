//
//  WPClientConfiguration.swift
//
//
//  Created by Ulaş Sancak on 26.02.2024.
//

import Foundation
import Resting

struct WPClientConfiguration: Sendable {
    enum ParameterType: Sendable {
        case object([String: any Sendable])
        case model(Encodable & Sendable)
    }
    
    enum EndpointType: Sendable {
        case base(baseURL: String, endpoint: String)
        case endpoint(String)
    }
    let endpointType: EndpointType
    let method: HTTPMethod
    let encoding: HTTPEncoding
    let headers: [String: String]?
    let parameterType: ParameterType?

    init(endpoint: String, method: HTTPMethod = .get, parameters: [String : any Sendable]?, encoding: HTTPEncoding = .urlEncoded, headers: [String: String]? = nil) {
        self.endpointType = .endpoint(endpoint)
        self.method = method
        self.encoding = encoding
        if let parameters {
            self.parameterType = .object(parameters)
        } else {
            self.parameterType = nil
        }
        self.headers = headers
    }

    init(endpoint: String, method: HTTPMethod = .post, requestModel: (Encodable & Sendable)?, encoding: HTTPEncoding = .json, headers: [String: String]? = nil) {
        self.endpointType = .endpoint(endpoint)
        self.method = method
        self.encoding = encoding
        if let requestModel {
            self.parameterType = .model(requestModel)
        } else {
            self.parameterType = nil
        }
        self.headers = headers
    }
    
    init(baseURL: String, endpoint: String, method: HTTPMethod = .get, parameters: [String : any Sendable]?, encoding: HTTPEncoding = .urlEncoded, headers: [String: String]? = nil) {
        self.endpointType = .base(baseURL: baseURL, endpoint: endpoint)
        self.method = method
        self.encoding = encoding
        if let parameters {
            self.parameterType = .object(parameters)
        } else {
            self.parameterType = nil
        }
        self.headers = headers
    }

    init(baseURL: String, endpoint: String, method: HTTPMethod = .post, requestModel: (Encodable & Sendable)?, encoding: HTTPEncoding = .json, headers: [String: String]? = nil) {
        self.endpointType = .base(baseURL: baseURL, endpoint: endpoint)
        self.method = method
        self.encoding = encoding
        if let requestModel {
            self.parameterType = .model(requestModel)
        } else {
            self.parameterType = nil
        }
        self.headers = headers
    }
}
