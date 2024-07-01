//
//  CategoriessRepositoryTests.swift
//
//
//  Created by Ulaş Sancak on 7.10.2023.
//

import XCTest
@testable import WPSwift

final class CategoriessRepositoryTests: XCTestCase {
    
    override func setUpWithError() throws {
        WPSwift.initialize(route: "https://www.example.com/wp-json", namespace: "wp/v2")
        WPSwift.sessionConfiguration.protocolClasses = [MockedURLProtocol.self]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        WPSwift.sessionConfiguration.protocolClasses = nil
    }

    func testGetCategoriess() async throws {
        MockedURLProtocol.observer = { request -> (URLResponse?, Data?) in
            let response = HTTPURLResponse(url: URL(string: WPEndpoint.Posts.posts.path)!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response, try [Post].mockData)
        }
        
        let repository = PostsRepository()
        let postsFromData = try await repository.getPostsClient().fetch()
        XCTAssert(!postsFromData.isEmpty, "Posts from json file looks empty!")

        let posts: [Post] = .mock
        XCTAssert(!posts.isEmpty, "Posts from mock looks empty!")

        let postFromData = postsFromData[0]
        let post = posts[0]

        // Assertions for all fields
        XCTAssertEqual(post.id, postFromData.id)
        XCTAssertEqual(post.date, postFromData.date)
        XCTAssertEqual(post.modified, postFromData.modified)
        XCTAssertEqual(post.status, postFromData.status)
        XCTAssertEqual(post.title.rendered, postFromData.title.rendered)
        XCTAssertEqual(post.content.rendered, postFromData.content.rendered)
        XCTAssertEqual(post.excerpt.rendered, postFromData.excerpt.rendered)
        XCTAssertEqual(post.author, postFromData.author)
        XCTAssertEqual(post.featured_media, postFromData.featured_media)
        XCTAssertEqual(post.comment_status, postFromData.comment_status)

        XCTAssertNotNil(post.categories)
        XCTAssertNotNil(postFromData.categories)

        XCTAssertNotNil(post.tags)
        XCTAssertNotNil(postFromData.tags)

        let authorFromData = postFromData.embeddedContent.author!
        let author = post.embeddedContent.author!

        // Assertions for author
        XCTAssertEqual(author.id, authorFromData.id)
        XCTAssertEqual(author.name, authorFromData.name)
        XCTAssertEqual(author.description, authorFromData.description)

        let featuredMediaFromData = postFromData.embeddedContent.featuredMedia!
        let featuredMedia = post.embeddedContent.featuredMedia!

        // Assertions for featured media
        XCTAssertEqual(featuredMedia.id, featuredMediaFromData.id)
        XCTAssertEqual(featuredMedia.sourceURL, featuredMediaFromData.sourceURL)
        XCTAssertEqual(featuredMedia.caption.rendered, featuredMediaFromData.caption.rendered)
        XCTAssertEqual(featuredMedia.altText, featuredMediaFromData.altText)
        XCTAssertEqual(featuredMedia.mediaDetails.width, featuredMediaFromData.mediaDetails.width)
        XCTAssertEqual(featuredMedia.mediaDetails.height, featuredMediaFromData.mediaDetails.height)
        XCTAssertEqual(featuredMedia.thumbnailURL, featuredMediaFromData.thumbnailURL)

        XCTAssertEqual(featuredMedia.mediaDetails.height, featuredMediaFromData.mediaDetails.height)
        XCTAssertEqual(featuredMedia.mediaDetails.width, featuredMediaFromData.mediaDetails.width)
        XCTAssertEqual(featuredMedia.mediaDetails.sizes.count, featuredMediaFromData.mediaDetails.sizes.count)
        let thumbnailFromData = featuredMediaFromData.mediaDetails.sizes["thumbnail"]!
        let thumbnail = featuredMedia.mediaDetails.sizes["thumbnail"]!

        // Assertions for thumbnail
        XCTAssertEqual(thumbnail.width, thumbnailFromData.width)
        XCTAssertEqual(thumbnail.height, thumbnailFromData.height)
        XCTAssertEqual(thumbnail.sourceURL, thumbnailFromData.sourceURL)

        // Assertions for category
        let category = post.embeddedContent.category!
        let categoryFromData = postFromData.embeddedContent.category!

        XCTAssertEqual(category.id, categoryFromData.id)
        XCTAssertEqual(category.link, categoryFromData.link)
        XCTAssertEqual(category.name, categoryFromData.name)
        XCTAssertEqual(category.taxonomy, categoryFromData.taxonomy)

        //Assertions for tag
        let tag = post.embeddedContent.tag!
        let tagFromData = postFromData.embeddedContent.tag!

        XCTAssertEqual(tag.id, tagFromData.id)
        XCTAssertEqual(tag.link, tagFromData.link)
        XCTAssertEqual(tag.name, tagFromData.name)
        XCTAssertEqual(tag.taxonomy, tagFromData.taxonomy)
    }

    func testGetPost() async throws {
        MockedURLProtocol.observer = { request -> (URLResponse?, Data?) in
            let response = HTTPURLResponse(url: URL(string: WPEndpoint.Posts.posts.path)!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response, try Post.mockData)
        }

        let repository = PostsRepository()
        let postFromData = try await repository.getPostClient(by: 1234).fetch()
        let post: Post = .mock

        // Assertions for all fields
        XCTAssertEqual(post.id, postFromData.id)
        XCTAssertEqual(post.date, postFromData.date)
        XCTAssertEqual(post.modified, postFromData.modified)
        XCTAssertEqual(post.status, postFromData.status)
        XCTAssertEqual(post.title.rendered, postFromData.title.rendered)
        XCTAssertEqual(post.content.rendered, postFromData.content.rendered)
        XCTAssertEqual(post.excerpt.rendered, postFromData.excerpt.rendered)
        XCTAssertEqual(post.author, postFromData.author)
        XCTAssertEqual(post.featured_media, postFromData.featured_media)
        XCTAssertEqual(post.comment_status, postFromData.comment_status)

        XCTAssertNotNil(post.categories)
        XCTAssertNotNil(postFromData.categories)

        XCTAssertNotNil(post.tags)
        XCTAssertNotNil(postFromData.tags)
        
        let authorFromData = postFromData.embeddedContent.author!
        let author = post.embeddedContent.author!
        
        // Assertions for author
        XCTAssertEqual(author.id, authorFromData.id)
        XCTAssertEqual(author.name, authorFromData.name)
        XCTAssertEqual(author.description, authorFromData.description)
        
        let featuredMediaFromData = postFromData.embeddedContent.featuredMedia!
        let featuredMedia = post.embeddedContent.featuredMedia!
        
        // Assertions for featured media
        XCTAssertEqual(featuredMedia.id, featuredMediaFromData.id)
        XCTAssertEqual(featuredMedia.sourceURL, featuredMediaFromData.sourceURL)
        XCTAssertEqual(featuredMedia.caption.rendered, featuredMediaFromData.caption.rendered)
        XCTAssertEqual(featuredMedia.altText, featuredMediaFromData.altText)
        XCTAssertEqual(featuredMedia.mediaDetails.width, featuredMediaFromData.mediaDetails.width)
        XCTAssertEqual(featuredMedia.mediaDetails.height, featuredMediaFromData.mediaDetails.height)
        XCTAssertEqual(featuredMedia.thumbnailURL, featuredMediaFromData.thumbnailURL)
        
        XCTAssertEqual(featuredMedia.mediaDetails.height, featuredMediaFromData.mediaDetails.height)
        XCTAssertEqual(featuredMedia.mediaDetails.width, featuredMediaFromData.mediaDetails.width)
        XCTAssertEqual(featuredMedia.mediaDetails.sizes.count, featuredMediaFromData.mediaDetails.sizes.count)
        let thumbnailFromData = featuredMediaFromData.mediaDetails.sizes["thumbnail"]!
        let thumbnail = featuredMedia.mediaDetails.sizes["thumbnail"]!

        // Assertions for thumbnail
        XCTAssertEqual(thumbnail.width, thumbnailFromData.width)
        XCTAssertEqual(thumbnail.height, thumbnailFromData.height)
        XCTAssertEqual(thumbnail.sourceURL, thumbnailFromData.sourceURL)

        // Assertions for category
        let category = post.embeddedContent.category!
        let categoryFromData = postFromData.embeddedContent.category!

        XCTAssertEqual(category.id, categoryFromData.id)
        XCTAssertEqual(category.link, categoryFromData.link)
        XCTAssertEqual(category.name, categoryFromData.name)
        XCTAssertEqual(category.taxonomy, categoryFromData.taxonomy)

        //Assertions for tag
        let tag = post.embeddedContent.tag!
        let tagFromData = postFromData.embeddedContent.tag!

        XCTAssertEqual(tag.id, tagFromData.id)
        XCTAssertEqual(tag.link, tagFromData.link)
        XCTAssertEqual(tag.name, tagFromData.name)
        XCTAssertEqual(tag.taxonomy, tagFromData.taxonomy)
    }

    func testCreatingPost() async throws {
        MockedURLProtocol.observer = { request -> (URLResponse?, Data?) in
            let response = HTTPURLResponse(url: URL(string: WPEndpoint.Posts.posts.path)!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response, try Post.mockData)
        }

        let post: PostToCreate = .mock

        let repository = PostsRepository()
        let postFromData = try await repository.createPostClient(by: post).fetch()

        // Assertions for all fields
        XCTAssertNotNil(postFromData.date)
        XCTAssertNotNil(postFromData.modified)
        XCTAssertEqual(post.status, postFromData.status)
        XCTAssertEqual(post.title.rendered, postFromData.title.rendered)
        XCTAssertEqual(post.content.rendered, postFromData.content.rendered)
        XCTAssertEqual(post.excerpt?.rendered, postFromData.excerpt.rendered)
        XCTAssertEqual(post.comment_status, postFromData.comment_status)

        XCTAssertNotNil(post.categories)
        XCTAssertNotNil(postFromData.categories)

        XCTAssertNotNil(post.tags)
        XCTAssertNotNil(postFromData.tags)
        
        XCTAssertNotNil(postFromData.embeddedContent.author)
        XCTAssertNotNil(postFromData.embeddedContent.featuredMedia)
        XCTAssertNotNil(postFromData.embeddedContent.tag)
        XCTAssertNotNil(postFromData.embeddedContent.category)
    }

    func testUpdatingPost() async throws {
        MockedURLProtocol.observer = { request -> (URLResponse?, Data?) in
            let response = HTTPURLResponse(url: URL(string: WPEndpoint.Posts.posts.path)!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response, try Post.mockData)
        }

        let post: PostToUpdate = .mock

        let repository = PostsRepository()
        let postFromData = try await repository.updatePostClient(by: 1234, post: post).fetch()

        // Assertions for all fields
        XCTAssertEqual(post.id, postFromData.id)
        XCTAssertNotNil(postFromData.date)
        XCTAssertNotNil(postFromData.modified)
        XCTAssertEqual(post.status, postFromData.status)
        XCTAssertEqual(post.title.rendered, postFromData.title.rendered)
        XCTAssertEqual(post.content.rendered, postFromData.content.rendered)
        XCTAssertEqual(post.excerpt?.rendered, postFromData.excerpt.rendered)
        XCTAssertEqual(post.comment_status, postFromData.comment_status)

        XCTAssertNotNil(post.categories)
        XCTAssertNotNil(postFromData.categories)

        XCTAssertNotNil(post.tags)
        XCTAssertNotNil(postFromData.tags)
        
        XCTAssertNotNil(postFromData.embeddedContent.author)
        XCTAssertNotNil(postFromData.embeddedContent.featuredMedia)
        XCTAssertNotNil(postFromData.embeddedContent.tag)
        XCTAssertNotNil(postFromData.embeddedContent.category)
    }

}
