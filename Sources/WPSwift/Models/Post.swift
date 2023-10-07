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

struct Post: BasePost, Codable {
    let id: Int
    let date: Date?
    let date_gmt: Date?
    let guid: RenderedContent?
    let modified: String?
    let modified_gmt: String?
    let slug: String?
    let status: String?
    let type: String?
    let link: String?
    let title: RenderedContent?
    let content: RenderedContent?
    let excerpt: RenderedContent?
    let author: Int?
    let featured_media: Int?
    let comment_status: String?
    let ping_status: String?
    let sticky: Bool?
    let template: String?
    let format: String?
    let meta: [String: AnyCodable]?
    let categories: [Int]?
    let tags: [Int]?
    let password: String?
    let permalink_template: String?
    let generated_slug: String?
    let _links: [String: [LinkDetails]]?
}

struct PostToCreate: BasePost, Encodable {
    let title: RenderedContent
    let content: RenderedContent
    let date: Date? // ISO 8601 formatted date string
    let date_gmt: Date? // ISO 8601 formatted date string in GMT
    let slug: String?
    let author: Int? // User ID of the author
    let featured_media: Int? // Media ID for the featured image
    let format: String?
    let sticky: Bool?
    let template: String?
    let excerpt: RenderedContent?
    let status: String?
    let password: String?
    let comment_status: String?
    let ping_status: String?
    let categories: [Int]?
    let tags: [Int]?
    let meta: [String: AnyCodable]?
}

struct PostToUpdate: BasePost, Encodable {
    let id: Int
    let title: RenderedContent
    let content: RenderedContent
    let date: Date? // ISO 8601 formatted date string
    let date_gmt: Date? // ISO 8601 formatted date string in GMT
    let slug: String?
    let author: Int? // User ID of the author
    let featured_media: Int? // Media ID for the featured image
    let format: String?
    let sticky: Bool?
    let template: String?
    let excerpt: RenderedContent?
    let status: String?
    let password: String?
    let comment_status: String?
    let ping_status: String?
    let categories: [Int]?
    let tags: [Int]?
    let meta: [String: AnyCodable]?
}

struct RenderedContent: Codable {
    let rendered: String?
    let protected: Bool?

    init(rendered: String? = nil, protected: Bool? = nil) {
        self.rendered = rendered
        self.protected = protected
    }
}

struct LinkDetails: Codable {
    let href: String?
    let embeddable: Bool?
    let post_type: String?
    let taxonomy: String?

    init(href: String? = nil, embeddable: Bool? = nil, post_type: String? = nil, taxonomy: String? = nil) {
        self.href = href
        self.embeddable = embeddable
        self.post_type = post_type
        self.taxonomy = taxonomy
    }
}
