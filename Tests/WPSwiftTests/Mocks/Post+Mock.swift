//
//  SimplePost+Mock.swift
//
//
//  Created by Ulaş Sancak on 5.07.2023.
//

import Foundation
@testable import WPSwift

extension SimplePost {
    static var mockData: Data {
        get throws {
            guard let url = Bundle.module.url(forResource: "SimplePost", withExtension: "json") else {
                throw MockError.fileNotFound("SimplePost.json")
            }
            let data = try Data(contentsOf: url)
            return data
        }
    }
    static var mockFromData: SimplePost {
        get throws {
            let data = try mockData
            let decoder = JSONDecoder.initialize()
            let post = try decoder.decode(SimplePost.self, from: data)
            return post
        }
    }
    static var mock: SimplePost {
        .init(
            id: 1234,
            title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            link: "https://example.com/1234"
        )
    }
}

extension [SimplePost] {
    static var mockData: Data {
        get throws {
            guard let url = Bundle.module.url(forResource: "SimplePosts", withExtension: "json") else {
                throw MockError.fileNotFound("SimplePosts.json")
            }
            let data = try Data(contentsOf: url)
            return data
        }
    }
    static var mockFromData: [SimplePost] {
        get throws {
            let data = try mockData
            let decoder = JSONDecoder.initialize()
            let posts = try decoder.decode([SimplePost].self, from: data)
            return posts
        }
    }
    static var mock: [SimplePost] {
        [SimplePost.mock]
    }
}

