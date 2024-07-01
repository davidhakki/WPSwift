//
//  CategoriesRepository.swift
//
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation
import Resting

public struct CategoriesRepository {
    public init() {}
    
    public func getCategoriesClient(page: Int = 1, perPage: Int = 10, order: OrderType = .descending) throws -> WPClient<EmptyModel, [PostCategory]> {
        try .init(.init(endpoint: WPEndpoint.Categories.categories.path, parameters: .createParamsForCategories(page: page, perPage: perPage, order: order)))
    }
    
    public func getCategoryClient(by id: Int) throws -> WPClient<EmptyModel, PostCategory> {
        try .init(.init(endpoint: WPEndpoint.Categories.category(id: id).path, parameters: nil))
    }

    public func createCategoryClient(by category: PostCategoryToCreate) throws -> WPClient<PostCategoryToCreate, PostCategory> {
        try .init(.init(endpoint: WPEndpoint.Categories.categories.path, method: .post, requestModel: category))
    }

    public func updateCategoryClient(by id: Int, category: PostCategoryToUpdate) throws -> WPClient<PostCategoryToUpdate, PostCategory> {
        try .init(.init(endpoint: WPEndpoint.Posts.post(id: id).path, method: .post, requestModel: category))
    }
}
