// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

enum WPConfigurationError: LocalizedError {
    case wasNotSetup
    case route
    case namespace

    var errorDescription: String? {
        switch self {
        case .wasNotSetup:
            Localization.Configuration.Error.notSetup.localized
        case .route:
            Localization.Configuration.Error.route.localized
        case .namespace:
            Localization.Configuration.Error.namespace.localized
        }
    }
}

struct WPConfiguration {
    let route: String
    let namespace: String
}

public struct WPSwift {
    static internal var configuration: WPConfiguration {
        get throws {
            guard let _configuration else { throw WPConfigurationError.wasNotSetup }
            guard !_configuration.route.isEmpty else { throw WPConfigurationError.route }
            guard !_configuration.namespace.isEmpty else { throw WPConfigurationError.namespace }
            return _configuration
        }
    }
    static private var _configuration: WPConfiguration?
    static let sessionConfiguration = URLSessionConfiguration.default

    static func resetConfiguration() {
        _configuration = nil
    }
}

public extension WPSwift {
    static func initialize(route: String, namespace: String) {
        WPSwift._configuration = .init(route: route, namespace: namespace)
    }
}
