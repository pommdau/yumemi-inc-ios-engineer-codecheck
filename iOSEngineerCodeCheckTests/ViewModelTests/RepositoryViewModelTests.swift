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
final class RepositoryViewModelTests: XCTestCase {
    
    var sut: RepositoryListViewModel<StubGitHubAPIService>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RepositoryListViewModel<StubGitHubAPIService>.init()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testSearchRepositoriesSuccess() async {

        // given
        sut.keyword = "swift"
        
        // when
        async let search: Void = sut.searchButtonPressed()
        while StubGitHubAPIService.shared.searchContinuation == nil {
            await Task.yield()
        }
        StubGitHubAPIService.shared.searchContinuation?
            .resume(returning: Repository.sampleData)
        StubGitHubAPIService.shared.searchContinuation = nil
        await search
        _ = await sut.task?.result  // searchButtonPressed()内のTask内の処理を待つ
   
        // then
        switch sut.repositories {
        case let .loaded(repositories):
            XCTAssertEqual(repositories.count, 2)
        default:
            XCTFail()
        }
    }
}
