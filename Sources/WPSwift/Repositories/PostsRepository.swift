//
//  File.swift
//  
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation

@available(macOS 14.0, *)
public struct PostsRepository {
    public func getPostsClient() throws -> APIClient<EmptyModel, [Post]> {
        try .init(.init(endpoint: APIEndpoint.Posts.posts.path, method: .get))
    }
    
    public func getPostClient(by id: Int) throws -> APIClient<EmptyModel, Post> {
        try .init(.init(endpoint: APIEndpoint.Posts.post(id: id).path, method: .get))
    }

    public func createPostClient(by post: PostToCreate) throws -> APIClient<PostToCreate, Post> {
        try .init(.init(endpoint: APIEndpoint.Posts.posts.path, method: .post, requestModel: post))
    }

    public func updatePostClient(by id: Int, post: PostToUpdate) throws -> APIClient<PostToUpdate, Post> {
        try .init(.init(endpoint: APIEndpoint.Posts.post(id: id).path, method: .post, requestModel: post))
    }
}
