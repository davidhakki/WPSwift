//
//  File.swift
//  
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation
import Resting

public struct PostsRepository {
    public init() {}
    
    public func getPostsClient(page: Int = 1, perPage: Int = 10, order: OrderType = .descending, categories: [Int] = [], categoriesToExclude: [Int] = [], tags: [Int] = [], tagsToExclude: [Int] = []) throws -> WPClient<EmptyModel, [Post]> {
        try .init(.init(endpoint: WPEndpoint.Posts.posts.path, parameters: .createParamsForPosts(page: page, perPage: perPage, order: order, categories: categories, categoriesToExclude: categoriesToExclude, tags: tags, tagsToExclude: tagsToExclude)))
    }
    
    public func getPostClient(by id: Int) throws -> WPClient<EmptyModel, Post> {
        try .init(.init(endpoint: WPEndpoint.Posts.post(id: id).path, parameters: .createParamsForPost()))
    }

    public func createPostClient(by post: PostToCreate) throws -> WPClient<PostToCreate, Post> {
        try .init(.init(endpoint: WPEndpoint.Posts.posts.path, method: .post, requestModel: post))
    }

    public func updatePostClient(by id: Int, post: PostToUpdate) throws -> WPClient<PostToUpdate, Post> {
        try .init(.init(endpoint: WPEndpoint.Posts.post(id: id).path, method: .post, requestModel: post))
    }
}
