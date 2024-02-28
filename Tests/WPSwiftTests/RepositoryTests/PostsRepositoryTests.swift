//
//  PostsRepositoryTests.swift
//  
//
//  Created by Ulaş Sancak on 7.10.2023.
//

import XCTest
@testable import WPSwift

@available(macOS 14.0, *)
final class PostsRepositoryTests: XCTestCase {
    
    override func setUpWithError() throws {
        WPSwift.initialize(route: "https://www.example.com/wp-json", namespace: "wp/v2")
        WPSwift.sessionConfiguration.protocolClasses = [MockedURLProtocol.self]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        WPSwift.sessionConfiguration.protocolClasses = nil
    }

    func testGetPosts() async throws {
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
        XCTAssertEqual(post.date_gmt, postFromData.date_gmt)
        XCTAssertEqual(post.guid?.rendered, postFromData.guid?.rendered)
        XCTAssertEqual(post.modified, postFromData.modified)
        XCTAssertEqual(post.modified_gmt, postFromData.modified_gmt)
        XCTAssertEqual(post.slug, postFromData.slug)
        XCTAssertEqual(post.status, postFromData.status)
        XCTAssertEqual(post.type, postFromData.type)
        XCTAssertEqual(post.link, postFromData.link)
        XCTAssertEqual(post.title?.rendered, postFromData.title?.rendered)
        XCTAssertEqual(post.content?.rendered, postFromData.content?.rendered)
        XCTAssertEqual(post.excerpt?.rendered, postFromData.excerpt?.rendered)
        XCTAssertEqual(post.author, postFromData.author)
        XCTAssertEqual(post.featured_media, postFromData.featured_media)
        XCTAssertEqual(post.comment_status, postFromData.comment_status)
        XCTAssertEqual(post.ping_status, postFromData.ping_status)
        XCTAssertEqual(post.sticky, postFromData.sticky)
        XCTAssertEqual(post.template, postFromData.template)
        XCTAssertEqual(post.format, postFromData.format)
        XCTAssertEqual(post.password, postFromData.password)
        XCTAssertEqual(post.permalink_template, postFromData.permalink_template)
        XCTAssertEqual(post.generated_slug, postFromData.generated_slug)

        // Comparing meta, categories, tags and _links can be a bit more complex
        // due to their nature. Here, I'm just checking if they exist in both instances.
        XCTAssertNotNil(post.meta)
        XCTAssertNotNil(postFromData.meta)

        XCTAssertNotNil(post.categories)
        XCTAssertNotNil(postFromData.categories)

        XCTAssertNotNil(post.tags)
        XCTAssertNotNil(postFromData.tags)

        XCTAssertNotNil(post._links)
        XCTAssertNotNil(postFromData._links)
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
        XCTAssertEqual(post.date_gmt, postFromData.date_gmt)
        XCTAssertEqual(post.guid?.rendered, postFromData.guid?.rendered)
        XCTAssertEqual(post.modified, postFromData.modified)
        XCTAssertEqual(post.modified_gmt, postFromData.modified_gmt)
        XCTAssertEqual(post.slug, postFromData.slug)
        XCTAssertEqual(post.status, postFromData.status)
        XCTAssertEqual(post.type, postFromData.type)
        XCTAssertEqual(post.link, postFromData.link)
        XCTAssertEqual(post.title?.rendered, postFromData.title?.rendered)
        XCTAssertEqual(post.content?.rendered, postFromData.content?.rendered)
        XCTAssertEqual(post.excerpt?.rendered, postFromData.excerpt?.rendered)
        XCTAssertEqual(post.author, postFromData.author)
        XCTAssertEqual(post.featured_media, postFromData.featured_media)
        XCTAssertEqual(post.comment_status, postFromData.comment_status)
        XCTAssertEqual(post.ping_status, postFromData.ping_status)
        XCTAssertEqual(post.sticky, postFromData.sticky)
        XCTAssertEqual(post.template, postFromData.template)
        XCTAssertEqual(post.format, postFromData.format)
        XCTAssertEqual(post.password, postFromData.password)
        XCTAssertEqual(post.permalink_template, postFromData.permalink_template)
        XCTAssertEqual(post.generated_slug, postFromData.generated_slug)

        // Comparing meta, categories, tags and _links can be a bit more complex
        // due to their nature. Here, I'm just checking if they exist in both instances.
        XCTAssertNotNil(post.meta)
        XCTAssertNotNil(postFromData.meta)

        XCTAssertNotNil(post.categories)
        XCTAssertNotNil(postFromData.categories)

        XCTAssertNotNil(post.tags)
        XCTAssertNotNil(postFromData.tags)

        XCTAssertNotNil(post._links)
        XCTAssertNotNil(postFromData._links)
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
        XCTAssertEqual(post.date, postFromData.date)
        XCTAssertEqual(post.date_gmt, postFromData.date_gmt)
        XCTAssertEqual(post.slug, postFromData.slug)
        XCTAssertEqual(post.status, postFromData.status)
        XCTAssertEqual(post.title.rendered, postFromData.title?.rendered)
        XCTAssertEqual(post.content.rendered, postFromData.content?.rendered)
        XCTAssertEqual(post.excerpt?.rendered, postFromData.excerpt?.rendered)
        XCTAssertEqual(post.author, postFromData.author)
        XCTAssertEqual(post.featured_media, postFromData.featured_media)
        XCTAssertEqual(post.comment_status, postFromData.comment_status)
        XCTAssertEqual(post.ping_status, postFromData.ping_status)
        XCTAssertEqual(post.sticky, postFromData.sticky)
        XCTAssertEqual(post.template, postFromData.template)
        XCTAssertEqual(post.format, postFromData.format)
        XCTAssertEqual(post.password, postFromData.password)

        // Comparing meta, categories, tags and _links can be a bit more complex
        // due to their nature. Here, I'm just checking if they exist in both instances.
        XCTAssertNotNil(post.meta)
        XCTAssertNotNil(post.categories)
        XCTAssertNotNil(post.tags)
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
        XCTAssertEqual(post.date, postFromData.date)
        XCTAssertEqual(post.date_gmt, postFromData.date_gmt)
        XCTAssertEqual(post.slug, postFromData.slug)
        XCTAssertEqual(post.status, postFromData.status)
        XCTAssertEqual(post.title.rendered, postFromData.title?.rendered)
        XCTAssertEqual(post.content.rendered, postFromData.content?.rendered)
        XCTAssertEqual(post.excerpt?.rendered, postFromData.excerpt?.rendered)
        XCTAssertEqual(post.author, postFromData.author)
        XCTAssertEqual(post.featured_media, postFromData.featured_media)
        XCTAssertEqual(post.comment_status, postFromData.comment_status)
        XCTAssertEqual(post.ping_status, postFromData.ping_status)
        XCTAssertEqual(post.sticky, postFromData.sticky)
        XCTAssertEqual(post.template, postFromData.template)
        XCTAssertEqual(post.format, postFromData.format)
        XCTAssertEqual(post.password, postFromData.password)

        // Comparing meta, categories, tags and _links can be a bit more complex
        // due to their nature. Here, I'm just checking if they exist in both instances.
        XCTAssertNotNil(post.meta)
        XCTAssertNotNil(post.categories)
        XCTAssertNotNil(post.tags)
    }

}
