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
            .find(text: R.string.localizable.repositorySearchScreenReadyViewTitle())
            .string()
        XCTAssertEqual(R.string.localizable.repositorySearchScreenReadyViewTitle(), inspectedName)
        
        let inspectedDescription = try view
            .inspect()
            .find(text: R.string.localizable.repositorySearchScreenReadyViewInformativeText())
            .string()
        XCTAssertEqual(R.string.localizable.repositorySearchScreenReadyViewInformativeText(), inspectedDescription)
    }
    
    // MARK: - SearchResultView Tests
    
    func testSearchResultViewWhenReady() throws {
        let viewModel: SearchResultViewModel<GitHubAPIClient> = .init()
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
        let viewModel: SearchResultViewModel<GitHubAPIClient> = .init(repos: .loading)
        let view = SearchResultView(viewModel: viewModel)
        
        let expectation = view.inspection.inspect { view in
            // 期待するViewが表示されているか
            let repoListSkelton = view.findAll(RepoListSkelton.self)
            XCTAssertNotNil(repoListSkelton)
        }
        ViewHosting.host(view: view)
        self.wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchResultViewWhenReposExist() throws {
        let viewModel: SearchResultViewModel<GitHubAPIClient> = .init(repos: .loaded(Repo.sampleData))
        let view = SearchResultView(viewModel: viewModel)
        
        let expectation = view.inspection.inspect { view in
            // 期待するViewが表示されているか
            let repoList = view.findAll(RepoList.self)
            XCTAssertNotNil(repoList)
            
            // セル数の確認
            let cells = view.findAll(RepoCell.self)
            XCTAssertEqual(cells.count, Repo.sampleData.count)
        }
        ViewHosting.host(view: view)
        self.wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchResultViewWhenRepoIsEmpty() throws {
        let viewModel: SearchResultViewModel<GitHubAPIClient> = .init(repos: .loaded([]))
        let view = SearchResultView(viewModel: viewModel)
        
        let expectation = view.inspection.inspect { view in
            // 期待するViewが表示されているか
            let repoList = view.findAll(RepoList.self)
            XCTAssertNotNil(repoList)
            _ = try view.find(text: R.string.localizable.repositorySearchScreenRepoListNoRepositoryText())
        }
        ViewHosting.host(view: view)
        self.wait(for: [expectation], timeout: 1.0)
    }
}
