//
//  MockedURLProtocol.swift
//  
//
//  Created by Ulaş Sancak on 2.10.2023.
//

import Foundation

class MockedURLProtocol: URLProtocol {
    nonisolated(unsafe) static var observer: ((URLRequest) throws -> (URLResponse?, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canInit(with task: URLSessionTask) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        do {
            guard let (response, data) = try Self.observer?(request) else {
                return
            }
            if let response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data {
                client?.urlProtocol(self, didLoad: data)
            }

            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() { }
}
