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
    static func createParamsForPosts(page: Int = 1, perPage: Int = 10, order: OrderType = .descending) -> [String: Any] {
        [
            "page": page,
            "per_page": perPage,
            "order": order.rawValue,
            "_embed": "",
            "_fields":"id,date_gmt,modified_gmt,status,title,content.rendered,excerpt,author,featured_media,comment_status,categories,tags,_links.author,_links.wp:featuredmedia,_links.wp:term"
        ]
    }
    
    static func createParamsForCategories(page: Int = 1, perPage: Int = 10, order: OrderType = .descending) -> [String: Any] {
        [
            "page": page,
            "per_page": perPage,
            "order": order.rawValue,
            "_fields":"id,count,description,link,name,parent"
        ]
    }
}
