//
//  CategoriesRepositoryTests.swift
//  
//
//  Created by Ulaş Sancak on 7.10.2023.
//

import XCTest
@testable import WPSwift

final class CategoriesRepositoryTests: XCTestCase {
    
    override func setUpWithError() throws {
        WPSwift.initialize(route: "https://www.example.com/wp-json", namespace: "wp/v2")
        WPSwift.sessionConfiguration.protocolClasses = [MockedURLProtocol.self]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        WPSwift.sessionConfiguration.protocolClasses = nil
    }

    func testGetCategories() async throws {
        MockedURLProtocol.observer = { request -> (URLResponse?, Data?) in
            let response = HTTPURLResponse(url: URL(string: WPEndpoint.Categories.categories.path)!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response, try [PostCategory].mockData)
        }
        
        let repository = CategoriesRepository()
        let categoriesFromData = try await repository.getCategoriesClient().fetch()
        XCTAssert(!categoriesFromData.isEmpty, "Categories from json file looks empty!")

        let categorys: [PostCategory] = .mock
        XCTAssert(!categorys.isEmpty, "Categories from mock looks empty!")

        let categoryFromData = categoriesFromData[0]
        let category = categorys[0]

        // Assertions for all fields
        XCTAssertEqual(category.id, categoryFromData.id)
        XCTAssertEqual(category.count, categoryFromData.count)
        XCTAssertEqual(category.description, categoryFromData.description)
        XCTAssertEqual(category.link, categoryFromData.link)
        XCTAssertEqual(category.name, categoryFromData.name)
        XCTAssertEqual(category.parent, categoryFromData.parent)
    }

    func testGetCategory() async throws {
        MockedURLProtocol.observer = { request -> (URLResponse?, Data?) in
            let response = HTTPURLResponse(url: URL(string: WPEndpoint.Categories.categories.path)!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response, try PostCategory.mockData)
        }

        let repository = CategoriesRepository()
        let categoryFromData = try await repository.getCategoryClient(by: 1234).fetch()
        let category: PostCategory = .mock

        // Assertions for all fields
        XCTAssertEqual(category.id, categoryFromData.id)
        XCTAssertEqual(category.count, categoryFromData.count)
        XCTAssertEqual(category.description, categoryFromData.description)
        XCTAssertEqual(category.link, categoryFromData.link)
        XCTAssertEqual(category.name, categoryFromData.name)
        XCTAssertEqual(category.parent, categoryFromData.parent)
    }

    func testCreatingCategory() async throws {
        MockedURLProtocol.observer = { request -> (URLResponse?, Data?) in
            let response = HTTPURLResponse(url: URL(string: WPEndpoint.Categories.categories.path)!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response, try PostCategory.mockData)
        }

        let category: PostCategoryToCreate = .mock

        let repository = CategoriesRepository()
        let categoryFromData = try await repository.createCategoryClient(by: category).fetch()

        // Assertions for all fields
        XCTAssertEqual(category.description, categoryFromData.description)
        XCTAssertEqual(category.name, categoryFromData.name)
        XCTAssertEqual(category.parent, categoryFromData.parent)
    }

    func testUpdatingCategory() async throws {
        MockedURLProtocol.observer = { request -> (URLResponse?, Data?) in
            let response = HTTPURLResponse(url: URL(string: WPEndpoint.Categories.categories.path)!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response, try PostCategory.mockData)
        }

        let category: PostCategoryToUpdate = .mock

        let repository = CategoriesRepository()
        let categoryFromData = try await repository.updateCategoryClient(by: 1234, category: category).fetch()

        // Assertions for all fields
        XCTAssertEqual(category.id, categoryFromData.id)
        XCTAssertEqual(category.description, categoryFromData.description)
        XCTAssertEqual(category.name, categoryFromData.name)
        XCTAssertEqual(category.parent, categoryFromData.parent)
    }

}
