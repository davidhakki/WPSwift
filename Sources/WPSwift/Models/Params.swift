//
//  PagingParams.swift
//
//
//  Created by Ulaş Sancak on 30.06.2024.
//

import Foundation

public enum OrderType: String, Decodable {
    case ascending = "asc"
    case descending = "desc"
}

extension [String: Any] {
    static func createParamsForPost(categories: [Int] = [], categoriesToExclude: [Int] = [], tags: [Int] = [], tagsToExclude: [Int] = []) -> [String: Any] {
        let categories = categories.map { "\($0)" }.joined(separator: ",")
        let categoriesToExclude = categoriesToExclude.map { "\($0)" }.joined(separator: ",")
        let tags = tags.map { "\($0)" }.joined(separator: ",")
        let tagsToExclude = tagsToExclude.map { "\($0)" }.joined(separator: ",")
        var params: [String: Any] = [
            "_embed": "",
            "_fields":"id,date_gmt,modified_gmt,status,title,content.rendered,excerpt,author,featured_media,comment_status,categories,tags,_links.author,_links.wp:featuredmedia,_links.wp:term"
        ]
        if !categories.isEmpty {
            params["categories"] = categories
        }
        if !categoriesToExclude.isEmpty {
            params["categories_exclude"] = categoriesToExclude
        }
        if !tags.isEmpty {
            params["tags"] = tags
        }
        if !tagsToExclude.isEmpty {
            params["tags_exclude"] = tagsToExclude
        }
        return params
    }
    
    static func createParamsForPosts(page: Int = 1, perPage: Int = 10, order: OrderType = .descending, categories: [Int] = [], categoriesToExclude: [Int] = [], tags: [Int] = [], tagsToExclude: [Int] = []) -> [String: Any] {
        let categories = categories.map { "\($0)" }.joined(separator: ",")
        let categoriesToExclude = categoriesToExclude.map { "\($0)" }.joined(separator: ",")
        let tags = tags.map { "\($0)" }.joined(separator: ",")
        let tagsToExclude = tagsToExclude.map { "\($0)" }.joined(separator: ",")
        var params: [String: Any] = [
            "page": page,
            "per_page": perPage,
            "order": order.rawValue,
            "_embed": "",
            "_fields":"id,date_gmt,modified_gmt,status,title,content.rendered,excerpt,author,featured_media,comment_status,categories,tags,_links.author,_links.wp:featuredmedia,_links.wp:term"
        ]
        if !categories.isEmpty {
            params["categories"] = categories
        }
        if !categoriesToExclude.isEmpty {
            params["categories_exclude"] = categoriesToExclude
        }
        if !tags.isEmpty {
            params["tags"] = tags
        }
        if !tagsToExclude.isEmpty {
            params["tags_exclude"] = tagsToExclude
        }
        return params
    }

    static func createParamsForCategories(page: Int = 1, perPage: Int = 100, order: OrderType = .descending) -> [String: Any] {
        [
            "page": page,
            "per_page": perPage,
            "order": order.rawValue,
            "_fields":"id,count,description,link,name,parent"
        ]
    }
    
    static func createParamsForCategory() -> [String: Any] {
        [
            "_fields":"id,count,description,link,name,parent"
        ]
    }
}
