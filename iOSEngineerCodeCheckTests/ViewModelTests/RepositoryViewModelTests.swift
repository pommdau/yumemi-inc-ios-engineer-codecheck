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

    private var sut: RepositoryListViewModel<StubGitHubAPIService>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RepositoryListViewModel<StubGitHubAPIService>()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // MARK: - Searching Tests

    func testSearchRepositoriesWhenKeywordIsEmpty() async {
        // given
        sut.keyword = ""

        // when
        await sut.searchButtonPressed()

        // then
        switch sut.repositories {
        case .idle:
            break
        default:
            XCTFail()
        }
    }

    func testSearchRepositoriesAndSuccess() async {
        // given
        sut.keyword = "swift"

        // when
        async let search: Void = sut.searchButtonPressed()
        while StubGitHubAPIService.shared.searchContinuation == nil {
            await Task.yield()
        }

        // then

        // 検索中の状態になっているかの確認
        switch sut.repositories {
        case .loading:
            break
        default:
            XCTFail()
        }

        // GitHubAPIの実行
        StubGitHubAPIService.shared.searchContinuation?
            .resume(returning: Repository.sampleData)
        StubGitHubAPIService.shared.searchContinuation = nil
        await search
        _ = await sut.task?.result  // searchButtonPressed()内のTask内の処理を待つ

        // 検索後の状態の確認
        switch sut.repositories {
        case let .loaded(repositories):
            XCTAssertEqual(repositories.count, 2)
        default:
            XCTFail()
        }
    }

    // MARK: - Searching Fail Tests

    private func searchRepositories(withError error: Error) async {
        // given
        sut.keyword = "swift"

        // when
        async let search: Void = sut.searchButtonPressed()
        while StubGitHubAPIService.shared.searchContinuation == nil {
            await Task.yield()
        }
        StubGitHubAPIService.shared.searchContinuation?
            .resume(throwing: error)
        StubGitHubAPIService.shared.searchContinuation = nil
        await search
        _ = await sut.task?.result  // searchButtonPressed()内のTask内の処理を待つ
    }

    func testSearchRepositoriesAndFailWithConnectionError() async {
        // given/when
        await searchRepositories(
            withError:
                GitHubAPIServiceError.connectionError(MessageError(description: "(Debug) .connectionErrror"))
        )
        // then
        switch sut.repositories {
        case .failed:
            break
        default:
            XCTFail()
        }
    }

    func testSearchRepositoriesAndFailWithResponseParseErrorError() async {
        // given/when
        await searchRepositories(
            withError:
                GitHubAPIServiceError.responseParseError(MessageError(description: "(Debug) .connectionErrror"))
        )
        // then
        switch sut.repositories {
        case .failed:
            break
        default:
            XCTFail()
        }
    }

    func testSearchRepositoriesAndFailWithAPIError() async {
        // given/when
        await searchRepositories(
            withError:
                GitHubAPIServiceError.apiError(GitHubAPIError.sampleData[0])
        )
        // then
        switch sut.repositories {
        case .failed:
            break
        default:
            XCTFail()
        }
    }

    func testSearchRepositoriesAndFailWithOtherError() async {
        // given/when
        await searchRepositories(
            withError:
                MessageError(description: "(Debug) error")
        )
        // then
        switch sut.repositories {
        case .failed:
            break
        default:
            XCTFail()
        }
    }

}
