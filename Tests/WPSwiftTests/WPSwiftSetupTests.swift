//
//  WPSwiftSetupTests.swift
//  
//
//  Created by Ulaş Sancak on 30.09.2023.
//

import XCTest
@testable import WPSwift

final class WPSwiftSetupTests: XCTestCase {
    override func setUp() async throws {
        WPSwift.resetConfiguration()
    }

    func testSetupSuccess() throws {
        WPSwift.initialize(route: "https://www.example.com/wp-json", namespace: "wp/v2")
        _ = try WPSwift.configuration
    }

    func testSetupFailure() throws {
        do {
            _ = try WPSwift.configuration
        } catch WPConfigurationError.wasNotSetup {
            XCTAssertEqual(WPConfigurationError.wasNotSetup.errorDescription, "Wordpress Configuration was not setup. Use WPSwift.configuration function to set it up.", "WPConfigurationError.wasNotSetup is incorrect.")
        }
    }

    func testRouteSetupFailure() throws {
        WPSwift.initialize(route: "", namespace: "wp/v2")
        do {
            _ = try WPSwift.configuration
        } catch WPConfigurationError.route {
            XCTAssertEqual(WPConfigurationError.route.errorDescription, "Wordpress `route` is empty. Use WPSwift.configuration function to set it up.", "WPConfigurationError.route is incorrect.")
        }
    }

    func testNamespaceSetupFailure() throws {
        WPSwift.initialize(route: "https://www.example.com/wp-json", namespace: "")
        do {
            _ = try WPSwift.configuration
        } catch WPConfigurationError.namespace {
            XCTAssertEqual(WPConfigurationError.namespace.errorDescription, "Wordpress `namespace` is empty. Use WPSwift.configuration function to set it up.", "WPConfigurationError.namespace is incorrect.")
        }
    }
}
