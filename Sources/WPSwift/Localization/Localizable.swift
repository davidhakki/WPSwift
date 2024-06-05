//
//  File.swift
//  
//
//  Created by Ulaş Sancak on 1.10.2023.
//

import Foundation

protocol AllKeys {
    static var allKeys: [String] { get }
}

protocol Localizable: RawRepresentable, CaseIterable, AllKeys where RawValue == String {}

extension Localizable {
    static var allKeys: [String] {
        allCases.map { $0.rawValue }
    }
}

public enum Localization: String, Localizable {
    //Default cases
    case ok
    case yes
    case no
    case cancel
    case success
    case failure
    case unknown
    case unknownError = "unknown_error"
    case error
    case done
    case next

    //All keys as nested. This needs to be updated if another nested enum is added.
    public static var allKeys: [String] {
        allCases.map({ $0.rawValue })
        + Configuration.allKeys
    }

    //Cases for specific parts

    enum Configuration {
        enum Error: String, Localizable {
            case notSetup = "configuration.error.notSetup"
            case route = "configuration.error.route"
            case namespace = "configuration.error.namespace"
        }

        static var allKeys: [String] {
            Error.allKeys
        }
    }
}

extension Localizable {
    var localized: String {
        NSLocalizedString(rawValue, bundle: Bundle.module, comment: "")
    }

    func localized(_ args: CVarArg...) -> String {
        String(format: localized, args)
    }
}

