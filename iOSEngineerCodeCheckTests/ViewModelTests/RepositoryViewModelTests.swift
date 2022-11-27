//
//  RepositoryViewModelTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/11/26.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

@MainActor
final class LoginViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    @MainActor
    func testHoge() async {
        let viewModel: RepositoryListViewModel<StubSearchRepositories> = .init()
        
        viewModel.keyword = "sample"
        async let search: Void = viewModel.searchButtonPressed()
        while StubSearchRepositories.shared.searchContinuation == nil {
            await Task.yield()
        }
        viewModel.cancelSearching()
        
        StubSearchRepositories.shared.searchContinuation?
            .resume(throwing: GitHubAPIServiceError.connectionError(MessageError(description: "hoge")))
        StubSearchRepositories.shared.searchContinuation = nil
        try! await search
    }
    
}
