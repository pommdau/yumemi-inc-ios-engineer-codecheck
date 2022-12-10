//
//  EngineerCodeCheckUITests.swift
//  EngineerCodeCheckUITestsWithViewInspector
//
//  Created by HIROKI IKEUCHI on 2022/12/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import iOSEngineerCodeCheck

@MainActor
final class EngineerCodeCheckUITests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testViewInspectorBaseline() throws {
        let expected = "it lives!"
        let sut = Text(expected)
        let value = try sut.inspect().text().string()
        XCTAssertEqual(value, expected)
    }
    
    func testReadyView() throws {
        let view = ReadyView()
        let inspectedName = try view
            .inspect()
            .find(text: "GitHub内のリポジトリが検索できます")
            .string()
        XCTAssertEqual("GitHub内のリポジトリが検索できます", inspectedName)
        
        let inspectedDescription = try view
            .inspect()
            .find(text: "検索してみましょう")
            .string()
        XCTAssertEqual("検索してみましょう", inspectedDescription)
    }
    
    // MARK: - SearchResultView Tests
    
    func testSearchResultViewWhenReady() throws {
        let viewModel: RepositoryListViewModel<GitHubAPIService> = .init()
        let view = SearchResultView(viewModel: viewModel)
        let expectation = view.inspection.inspect { view in
            // 期待するViewが表示されているか
            let readyView = view.findAll(ReadyView.self)
            XCTAssertNotNil(readyView)
        }
        ViewHosting.host(view: view)
        self.wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchResultViewWhenLoading() throws {
        let viewModel: RepositoryListViewModel<GitHubAPIService> = .init()
        viewModel.repositories = .loading
        let view = SearchResultView(viewModel: viewModel)
        
        let expectation = view.inspection.inspect { view in
            // 期待するViewが表示されているか
            _ = try view.find(text: "検索しています…")
        }
        ViewHosting.host(view: view)
        self.wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchResultViewWhenRepositoriesExist() throws {
        let viewModel: RepositoryListViewModel<GitHubAPIService> = .init()
        viewModel.repositories = .loaded(Repository.sampleData)
        let view = SearchResultView(viewModel: viewModel)
        
        let expectation = view.inspection.inspect { view in
            // 期待するViewが表示されているか
            let repositoryList = view.findAll(RepositoryList.self)
            XCTAssertNotNil(repositoryList)
            
            // セル数の確認
            let cells = view.findAll(RepositoryCell.self)
            XCTAssertEqual(cells.count, Repository.sampleData.count)
        }
        ViewHosting.host(view: view)
        self.wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchResultViewWhenRepositorieyIsEmpty() throws {
        let viewModel: RepositoryListViewModel<GitHubAPIService> = .init()
        viewModel.repositories = .loaded([])
        let view = SearchResultView(viewModel: viewModel)
        
        let expectation = view.inspection.inspect { view in
            // 期待するViewが表示されているか
            let repositoryList = view.findAll(RepositoryList.self)
            XCTAssertNotNil(repositoryList)
            _ = try view.find(text: "該当するリポジトリが見つかりませんでした")
        }
        ViewHosting.host(view: view)
        self.wait(for: [expectation], timeout: 1.0)
    }
}
