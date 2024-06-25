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
    
    public func getPostsClient() throws -> WPClient<EmptyModel, [Post]> {
        try .init(.init(endpoint: WPEndpoint.Posts.posts.path, parameters: nil))
    }
    
    public func getPostClient(by id: Int) throws -> WPClient<EmptyModel, Post> {
        try .init(.init(endpoint: WPEndpoint.Posts.post(id: id).path, parameters: nil))
    }

    public func createPostClient(by post: PostToCreate) throws -> WPClient<PostToCreate, Post> {
        try .init(.init(endpoint: WPEndpoint.Posts.posts.path, method: .post, requestModel: post))
    }

    public func updatePostClient(by id: Int, post: PostToUpdate) throws -> WPClient<PostToUpdate, Post> {
        try .init(.init(endpoint: WPEndpoint.Posts.post(id: id).path, method: .post, requestModel: post))
    }
}
