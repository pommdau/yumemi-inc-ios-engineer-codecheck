//
//  RepoSearchScreenTests.swift
//  EngineerCodeCheckUITestsWithXCUITest
//
//  Created by HIROKI IKEUCHI on 2022/12/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest

final class RepoSearchScreenTests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-MockGitHubAPIService"]
        app.launch()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    // リポジトリ検索を行いCellが表示されるかどうかを確認
    // ViewInspectorがNavigationViewの.searchableに非対応(2022-12-10現在)のため、この部分のみXCUITestを遣う
    func testSearchRepoAndCheckCellExistence() throws {
        let navigationBar = app.navigationBars["_TtGC7SwiftUI19UIHosting"]
        let searchField = navigationBar.searchFields["検索"]
        searchField.tap()
        searchField.typeText("Swift")
        searchField.tap()
        XCTAssert(app.collectionViews.children(matching: .any).firstMatch.exists)
    }
}
