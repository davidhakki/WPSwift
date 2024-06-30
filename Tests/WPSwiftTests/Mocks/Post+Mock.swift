//
//  Post+Mock.swift
//
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation
@testable import WPSwift

extension Post {
    static var mockData: Data {
        get throws {
            guard let url = Bundle.module.url(forResource: "Post", withExtension: "json") else {
                throw MockError.fileNotFound("Post.json")
            }
            let data = try Data(contentsOf: url)
            return data
        }
    }
    static var mockFromData: Post {
        get throws {
            let data = try mockData
            let decoder = JSONDecoder.initialize()
            let post = try decoder.decode(Post.self, from: data)
            return post
        }
    }
    static var mock: Post {
        .init(
            id: 1234,
            date: DateFormatter.default.date(from: "2023-10-06T14:08:00"),
            modified: DateFormatter.default.date(from: "2023-10-06T14:08:00"),
            status: "publish",
            title: RenderedContent(rendered: "Sample Post Title"),
            content: RenderedContent(rendered: "<p>This is a mock post content.</p>"),
            excerpt: RenderedContent(rendered: "This is a mock post excerpt."),
            author: 1,
            featured_media: 5678,
            comment_status: "open",
            categories: [1, 2],
            tags: [3, 4],
            embeddedContent: .mock
        )
    }
}

extension [Post] {
    static var mockData: Data {
        get throws {
            guard let url = Bundle.module.url(forResource: "Posts", withExtension: "json") else {
                throw MockError.fileNotFound("Posts.json")
            }
            let data = try Data(contentsOf: url)
            return data
        }
    }
    static var mockFromData: [Post] {
        get throws {
            let data = try mockData
            let decoder = JSONDecoder.initialize()
            let posts = try decoder.decode([Post].self, from: data)
            return posts
        }
    }
    static var mock: [Post] {
        [Post.mock]
    }
}

extension PostToCreate {
    static var mock: PostToCreate {
        .init(
            title: RenderedContent(rendered: "Sample Post Title"),
            content: RenderedContent(rendered: "<p>This is a mock post content.</p>"),
            format: "standard",
            sticky: false,
            excerpt: RenderedContent(rendered: "This is a mock post excerpt."),
            status: "publish",
            password: "secretPassword",
            comment_status: "open",
            ping_status: "closed",
            categories: [10, 20],
            tags: [50, 60]
        )
    }
}

extension PostToUpdate {
    static var mock: PostToUpdate {
        .init(
            id: 1234,
            title: RenderedContent(rendered: "Sample Post Title"),
            content: RenderedContent(rendered: "<p>This is a mock post content.</p>"),
            format: "standard",
            sticky: false,
            excerpt: RenderedContent(rendered: "This is a mock post excerpt."),
            status: "publish",
            password: "secretPassword",
            comment_status: "open",
            ping_status: "closed",
            categories: [12, 22],
            tags: [52, 62]
        )
    }
}
