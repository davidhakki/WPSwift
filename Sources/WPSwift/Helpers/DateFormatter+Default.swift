//
//  ISO8601DateFormatter.swift
//
//
//  Created by Ulaş Sancak on 30.06.2024.
//

import Foundation

extension DateFormatter {
    static var `default`: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }
}
