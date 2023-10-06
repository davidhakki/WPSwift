//
//  File.swift
//  
//
//  Created by Ulaş Sancak on 6.10.2023.
//

import Foundation

enum APIEndpoint {
    enum Posts {
        case posts
        case post(id: Int)

        var path: String {
            switch self {
            case .posts:
                return "/posts"
            case .post(let id):
                return "/posts/\(id)"
            }
        }
    }
}
