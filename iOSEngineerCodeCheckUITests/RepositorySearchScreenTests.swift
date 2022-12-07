//
//  RepositorySearchScreenTests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by HIROKI IKEUCHI on 2022/12/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest

final class RepositorySearchScreenTests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testInitialView() throws {
        let mainText = app.staticTexts["検索してみましょう"]
        let subText = app.staticTexts["GitHub内のリポジトリが検索できます"]
        XCTAssert(mainText.exists)
        XCTAssert(subText.exists)
    }

    func testSearchRepository() throws {
        let navigationBar = app.navigationBars["_TtGC7SwiftUI19UIHosting"]
        let searchField = navigationBar.searchFields["検索"]
        searchField.tap()
        searchField.typeText("Swift")
    }
}
