//
//  PostCategory+Mock.swift
//
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation
@testable import WPSwift

extension PostCategory {
    static var mockData: Data {
        get throws {
            guard let url = Bundle.module.url(forResource: "Category", withExtension: "json") else {
                throw MockError.fileNotFound("Category.json")
            }
            let data = try Data(contentsOf: url)
            return data
        }
    }
    static var mockFromData: PostCategory {
        get throws {
            let data = try mockData
            let decoder = JSONDecoder.initialize()
            let category = try decoder.decode(PostCategory.self, from: data)
            return category
        }
    }
    static var mock: PostCategory {
        .init(
            id: 1234,
            count: 1,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            link: "http://example.com/categories/1234",
            name: "Lorem Ipsum",
            parent: 0
        )
    }
}

extension [PostCategory] {
    static var mockData: Data {
        get throws {
            guard let url = Bundle.module.url(forResource: "Categories", withExtension: "json") else {
                throw MockError.fileNotFound("Categories.json")
            }
            let data = try Data(contentsOf: url)
            return data
        }
    }
    static var mockFromData: [PostCategory] {
        get throws {
            let data = try mockData
            let decoder = JSONDecoder.initialize()
            let categories = try decoder.decode([PostCategory].self, from: data)
            return categories
        }
    }
    static var mock: [PostCategory] {
        [PostCategory.mock]
    }
}

extension PostCategoryToCreate {
    static var mock: PostCategoryToCreate {
        .init(
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            name: "Lorem Ipsum",
            parent: 0
        )
    }
}

extension PostCategoryToUpdate {
    static var mock: PostCategoryToUpdate {
        .init(
            id: 1234,
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            name: "Lorem Ipsum",
            parent: 0
        )
    }
}
