//
//  WPClientConfiguration.swift
//
//
//  Created by Ulaş Sancak on 26.02.2024.
//

import Foundation
import Resting

struct WPClientConfiguration {
    enum ParameterType {
        case object([String: Any])
        case model(Encodable)
    }

    let endpoint: String
    let method: HTTPMethod
    let encoding: HTTPEncoding
    let headers: [String: String]?
    let parameterType: ParameterType?

    init(endpoint: String, method: HTTPMethod = .get, parameters: [String : Any]?, encoding: HTTPEncoding = .urlEncoded, headers: [String: String]? = nil) {
        self.endpoint = endpoint
        self.method = method
        self.encoding = encoding
        if let parameters {
            self.parameterType = .object(parameters)
        } else {
            self.parameterType = nil
        }
        self.headers = headers
    }

    init(endpoint: String, method: HTTPMethod = .post, requestModel: Encodable?, encoding: HTTPEncoding = .json, headers: [String: String]? = nil) {
        self.endpoint = endpoint
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
