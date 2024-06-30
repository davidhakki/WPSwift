//
//  FeaturedMedia.swift
//
//
//  Created by Ulaş Sancak on 30.06.2024.
//

import Foundation

public struct FeaturedMedia: Codable {
    public let id: Int
    public let title: RenderedContent
    public let caption: RenderedContent
    public let altText:String
    public let mediaDetails: MediaDetails
    public let sourceURL: String
    public var thumbnailURL: String? {
        mediaDetails.sizes["thumbnail"]?.sourceURL
    }
    enum CodingKeys: String, CodingKey {
        case id, title
        case caption
        case altText = "alt_text"
        case mediaDetails = "media_details"
        case sourceURL = "source_url"
    }
}

public struct MediaDetails: Codable {
    public let width:Int
    public let height: Int
    public let sizes: [String: Size]

    enum CodingKeys: String, CodingKey {
        case width, height, sizes
    }
}

// MARK: - Size
public struct Size: Codable {
    public let width: Int
    public let height: Int
    public let sourceURL: String

    enum CodingKeys: String, CodingKey {
        case width, height
        case sourceURL = "source_url"
    }
}
