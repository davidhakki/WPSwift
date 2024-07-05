//
//  File.swift
//  
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation

enum WPEndpoint {
    enum Posts {
        case posts
        case post(id: Int)
        case search

        var path: String {
            switch self {
            case .posts:
                "/posts"
            case .post(let id):
                "/posts/\(id)"
            case .search:
                "/search"
            }
        }
    }
    
    enum Categories {
        case categories
        case category(id: Int)

        var path: String {
            switch self {
            case .categories:
                "/categories"
            case .category(let id):
                "/categoriy/\(id)"
            }
        }
    }
}
