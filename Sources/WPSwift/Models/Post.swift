//
//  Post.swift
//
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation

public struct Post: Decodable {
    public let id: Int
    public let date: Date?
    public let modified: Date?
    public let status: String
    public let title: RenderedContent
    public let content: RenderedContent
    public let excerpt: RenderedContent
    public let author: Int
    public let featured_media: Int
    public let comment_status: String
    public let categories: [Int]
    public let tags: [Int]
    public let embeddedContent: EmbeddedContent
    
    private enum CodingKeys: String, CodingKey {
        case id
        case date = "date_gmt"
        case modified = "modified_gmt"
        case status
        case title
        case content
        case excerpt
        case author
        case featured_media
        case comment_status
        case categories
        case tags
        case embeddedContent = "_embedded"
    }
    
    public init(id: Int, date: Date? = nil, modified: Date? = nil, status: String, title: RenderedContent, content: RenderedContent, excerpt: RenderedContent, author: Int, featured_media: Int, comment_status: String, categories: [Int], tags: [Int], embeddedContent: EmbeddedContent) {
        self.id = id
        self.date = date
        self.modified = modified
        self.status = status
        self.title = title
        self.content = content
        self.excerpt = excerpt
        self.author = author
        self.featured_media = featured_media
        self.comment_status = comment_status
        self.categories = categories
        self.tags = tags
        self.embeddedContent = embeddedContent
    }
}

public struct PostToCreate: Encodable {
    public let title: RenderedContent
    public let content: RenderedContent
    public let format: String?
    public let sticky: Bool?
    public let excerpt: RenderedContent?
    public let status: String?
    public let password: String?
    public let comment_status: String?
    public let ping_status: String?
    public let categories: [Int]
    public let tags: [Int]

    public init(title: RenderedContent, content: RenderedContent, format: String? = nil, sticky: Bool? = nil, excerpt: RenderedContent? = nil, status: String? = nil, password: String? = nil, comment_status: String? = nil, ping_status: String? = nil, categories: [Int], tags: [Int]) {
        self.title = title
        self.content = content
        self.format = format
        self.sticky = sticky
        self.excerpt = excerpt
        self.status = status
        self.password = password
        self.comment_status = comment_status
        self.ping_status = ping_status
        self.categories = categories
        self.tags = tags
    }
}

public struct PostToUpdate: Encodable {
    public let id: Int
    public let title: RenderedContent
    public let content: RenderedContent
    public let format: String?
    public let sticky: Bool?
    public let excerpt: RenderedContent?
    public let status: String?
    public let password: String?
    public let comment_status: String?
    public let ping_status: String?
    public let categories: [Int]
    public let tags: [Int]
    
    public init(id: Int, title: RenderedContent, content: RenderedContent, format: String? = nil, sticky: Bool? = nil, excerpt: RenderedContent? = nil, status: String? = nil, password: String? = nil, comment_status: String? = nil, ping_status: String? = nil, categories: [Int], tags: [Int]) {
        self.id = id
        self.title = title
        self.content = content
        self.format = format
        self.sticky = sticky
        self.excerpt = excerpt
        self.status = status
        self.password = password
        self.comment_status = comment_status
        self.ping_status = ping_status
        self.categories = categories
        self.tags = tags
    }
}

public struct RenderedContent: Codable {
    public let rendered: String
    public let protected: Bool

    public init(rendered: String, protected: Bool = false) {
        self.rendered = rendered
        self.protected = protected
    }
    
    enum CodingKeys: CodingKey {
        case rendered
        case protected
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rendered = try container.decode(String.self, forKey: .rendered)
        self.protected = try container.decodeIfPresent(Bool.self, forKey: .protected) ?? false
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.rendered, forKey: .rendered)
        try container.encode(self.protected, forKey: .protected)
    }
}
