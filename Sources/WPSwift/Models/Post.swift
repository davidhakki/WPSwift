//
//  Post.swift
//
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation

protocol BasePost {
    var date: Date? { get }
    var date_gmt: Date? { get }
    var slug: String? { get }
    var status: String? { get }
    var author: Int? { get } // User ID of the author
    var featured_media: Int? { get } // Media ID for the featured image
    var format: String? { get }
    var sticky: Bool? { get }
    var template: String? { get }
    var excerpt: RenderedContent? { get }
    var password: String? { get }
    var comment_status: String? { get }
    var ping_status: String? { get }
    var categories: [Int]? { get }
    var tags: [Int]? { get }
    var meta: [String: AnyCodable]? { get }
}

public struct Post: BasePost, Codable {
    public let id: Int
    public let date: Date?
    public let date_gmt: Date?
    public let guid: RenderedContent?
    public let modified: String?
    public let modified_gmt: String?
    public let slug: String?
    public let status: String?
    public let type: String?
    public let link: String?
    public let title: RenderedContent?
    public let content: RenderedContent?
    public let excerpt: RenderedContent?
    public let author: Int?
    public let featured_media: Int?
    public let comment_status: String?
    public let ping_status: String?
    public let sticky: Bool?
    public let template: String?
    public let format: String?
    public let meta: [String: AnyCodable]?
    public let categories: [Int]?
    public let tags: [Int]?
    public let password: String?
    public let permalink_template: String?
    public let generated_slug: String?
    public let _links: [String: [LinkDetails]]?
}

public struct PostToCreate: BasePost, Encodable {
    public let title: RenderedContent
    public let content: RenderedContent
    public let date: Date? // ISO 8601 formatted date string
    public let date_gmt: Date? // ISO 8601 formatted date string in GMT
    public let slug: String?
    public let author: Int? // User ID of the author
    public let featured_media: Int? // Media ID for the featured image
    public let format: String?
    public let sticky: Bool?
    public let template: String?
    public let excerpt: RenderedContent?
    public let status: String?
    public let password: String?
    public let comment_status: String?
    public let ping_status: String?
    public let categories: [Int]?
    public let tags: [Int]?
    public let meta: [String: AnyCodable]?
}

public struct PostToUpdate: BasePost, Encodable {
    public let id: Int
    public let title: RenderedContent
    public let content: RenderedContent
    public let date: Date? // ISO 8601 formatted date string
    public let date_gmt: Date? // ISO 8601 formatted date string in GMT
    public let slug: String?
    public let author: Int? // User ID of the author
    public let featured_media: Int? // Media ID for the featured image
    public let format: String?
    public let sticky: Bool?
    public let template: String?
    public let excerpt: RenderedContent?
    public let status: String?
    public let password: String?
    public let comment_status: String?
    public let ping_status: String?
    public let categories: [Int]?
    public let tags: [Int]?
    public let meta: [String: AnyCodable]?
}

public struct RenderedContent: Codable {
    public let rendered: String?
    public let protected: Bool?

    init(rendered: String? = nil, protected: Bool? = nil) {
        self.rendered = rendered
        self.protected = protected
    }
}

public struct LinkDetails: Codable {
    public let href: String?
    public let embeddable: Bool?
    public let post_type: String?
    public let taxonomy: String?

    init(href: String? = nil, embeddable: Bool? = nil, post_type: String? = nil, taxonomy: String? = nil) {
        self.href = href
        self.embeddable = embeddable
        self.post_type = post_type
        self.taxonomy = taxonomy
    }
}
