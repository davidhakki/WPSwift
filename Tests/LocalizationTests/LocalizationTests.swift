//
//  WPSwiftSetupTests.swift
//
//
//  Created by Ulaş Sancak on 30.09.2023.
//

import XCTest
@testable import WPSwift

class LocalizationTests: XCTestCase {
    
    func testLocalizations() throws {
        let localizations = Bundle.module.localizations
        for localization in localizations {
            guard let path = Bundle.module.path(forResource: localization, ofType: "lproj"),
            let bundle = Bundle(path: path) else {
                XCTAssert(false, "Localization file is missing for '" + localization + "'.")
                return
            }
            guard let localizationPath = bundle.path(forResource: "Localizable", ofType: "strings") else {
                XCTAssert(false, "Localizable.strings file is missing for " + localization + ".")
                return
            }
            guard let localizationKeys = NSDictionary(contentsOfFile: localizationPath)?.allKeys as? [String] else {
                XCTAssert(false, localization + "localization file is curropted.")
                return
            }
            let allKeys = Localization.allKeys
            for key in allKeys {
                XCTAssert(localizationKeys.contains(key), key + " key is missing from the " + localization + " file")
            }
            for key in localizationKeys {
                XCTAssert(allKeys.contains(key), "Found key '" + key + "' in localization file(" + localization + ") is not in Localization nested enum.")
            }
        }
    }

}
