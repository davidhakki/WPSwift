//
//  Post.swift
//
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation

public enum CommentStatus: String, Codable, Sendable {
    case `open`
    case closed
    case close
    
    public var isOpen: Bool {
        self == .open
    }
}

public struct Post: Decodable, Sendable {
    public let id: Int
    public let date: Date?
    public let modified: Date?
    public let status: String?
    public let title: RenderedContent
    public let content: RenderedContent
    public let excerpt: RenderedContent?
    public let author: Int?
    public let featuredMedia: Int?
    public let commentStatus: CommentStatus
    public let categories: [Int]
    public let tags: [Int]
    public let link: String
    public let embeddedContent: EmbeddedContent?
    public let htmlDecodedTitle: String
    public let contentHTML: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case date = "date_gmt"
        case modified = "modified_gmt"
        case status
        case title
        case content
        case excerpt
        case author
        case featuredMedia = "featured_media"
        case commentStatus = "comment_status"
        case categories
        case tags
        case link
        case embeddedContent = "_embedded"
        case contentHTML
    }
    
    public init(id: Int, date: Date? = nil, modified: Date? = nil, status: String? = nil, title: RenderedContent, content: RenderedContent, excerpt: RenderedContent?, author: Int, featuredMedia: Int?, commentStatus: CommentStatus, categories: [Int], tags: [Int], link: String, embeddedContent: EmbeddedContent?) {
        self.id = id
        self.date = date
        self.modified = modified
        self.status = status
        self.title = title
        self.content = content
        self.excerpt = excerpt
        self.author = author
        self.featuredMedia = featuredMedia
        self.commentStatus = commentStatus
        self.categories = categories
        self.tags = tags
        self.link = link
        self.embeddedContent = embeddedContent
        self.htmlDecodedTitle = title.rendered.decodedHTML
        self.contentHTML = nil
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.date = try container.decodeIfPresent(Date.self, forKey: .date)
        self.modified = try container.decodeIfPresent(Date.self, forKey: .modified)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        if let title = try? container.decodeIfPresent(RenderedContent.self, forKey: .title) {
            self.title = title
        } else if let title = try? container.decodeIfPresent(String.self, forKey: .title) {
            self.title = .init(rendered: title)
        } else {
            self.title = .init(rendered: "")
        }
        self.contentHTML = try container.decodeIfPresent(String.self, forKey: .contentHTML)
        if let content = try? container.decodeIfPresent(RenderedContent.self, forKey: .content) {
            self.content = content
        } else if let content = contentHTML {
            self.content = .init(rendered: content)
        } else if let content = try? container.decodeIfPresent(String.self, forKey: .content) {
            self.content = .init(rendered: content)
        } else {
            self.content = .init(rendered: "")
        }
        self.excerpt = try container.decodeIfPresent(RenderedContent.self, forKey: .excerpt)
        self.author = try container.decodeIfPresent(Int.self, forKey: .author)
        self.featuredMedia = try container.decodeIfPresent(Int.self, forKey: .featuredMedia)
        self.commentStatus = (try? container.decodeIfPresent(CommentStatus.self, forKey: .commentStatus)) ?? .closed
        self.categories = try container.decodeIfPresent([Int].self, forKey: .categories) ?? []
        self.tags = try container.decodeIfPresent([Int].self, forKey: .tags) ?? []
        self.link = try container.decode(String.self, forKey: .link)
        self.embeddedContent = try container.decodeIfPresent(EmbeddedContent.self, forKey: .embeddedContent)
        self.htmlDecodedTitle = title.rendered.decodedHTML
    }
}

public struct PostToCreate: Encodable, Sendable {
    public let title: RenderedContent
    public let content: RenderedContent
    public let format: String?
    public let sticky: Bool?
    public let excerpt: RenderedContent?
    public let status: String?
    public let password: String?
    public let commentStatus: CommentStatus?
    public let ping_status: String?
    public let categories: [Int]
    public let tags: [Int]

    public init(title: RenderedContent, content: RenderedContent, format: String? = nil, sticky: Bool? = nil, excerpt: RenderedContent? = nil, status: String? = nil, password: String? = nil, commentStatus: CommentStatus? = nil, ping_status: String? = nil, categories: [Int], tags: [Int]) {
        self.title = title
        self.content = content
        self.format = format
        self.sticky = sticky
        self.excerpt = excerpt
        self.status = status
        self.password = password
        self.commentStatus = commentStatus
        self.ping_status = ping_status
        self.categories = categories
        self.tags = tags
    }
}

public struct PostToUpdate: Encodable, Sendable {
    public let id: Int
    public let title: RenderedContent
    public let content: RenderedContent
    public let format: String?
    public let sticky: Bool?
    public let excerpt: RenderedContent?
    public let status: String?
    public let password: String?
    public let commentStatus: CommentStatus?
    public let ping_status: String?
    public let categories: [Int]
    public let tags: [Int]
    
    public init(id: Int, title: RenderedContent, content: RenderedContent, format: String? = nil, sticky: Bool? = nil, excerpt: RenderedContent? = nil, status: String? = nil, password: String? = nil, commentStatus: CommentStatus? = nil, ping_status: String? = nil, categories: [Int], tags: [Int]) {
        self.id = id
        self.title = title
        self.content = content
        self.format = format
        self.sticky = sticky
        self.excerpt = excerpt
        self.status = status
        self.password = password
        self.commentStatus = commentStatus
        self.ping_status = ping_status
        self.categories = categories
        self.tags = tags
    }
}

public struct RenderedContent: Codable, Sendable {
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
