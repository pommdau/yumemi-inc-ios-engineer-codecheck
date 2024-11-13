//
//  SearchResultViewModelTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/11/26.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class SearchResultViewModelTests: XCTestCase {

    // MARK: - Properties
    
    private var sut: SearchResultViewModel<GitHubAPIClientStub>!

    // MARK: - Setup/TearDown
    
    @MainActor
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchResultViewModel<GitHubAPIClientStub>()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // MARK: - リポジトリの検索
    
    // MARK: 検索フィールドが空の場合
    @MainActor
    func testSearchReposButtonPressedWhenKeywordIsEmpty() async {
        // given
        // when
        sut.keyword = ""
        await sut.searchButtonPressed()

        // then
        switch sut.repos {
        case .idle:
            break
        default:
            XCTFail("unexpected repos: \(sut.repos)")
        }
    }
    
    // 課題:検索のキャンセル処理のテストがうまく動作していないので一時的にコメントアウト
    /*
     task = Task {
         do {
         ...
         } catch {
         // ここの処理をwaitすることができていない
         }
     }
     */
    /*
    func testSearchReposButtonPressedAndCancel() async {
        // given
        // when
        async let search: Void = sut.searchButtonPressed(withKeyword: "swift)
        while StubGitHubAPIService.shared.searchContinuation == nil {
            await Task.yield()
        }

        // then

        // 検索中の状態になっているかの確認
        switch sut.repos {
        case .loading:
            break
        default:
            XCTFail("unexpected repos: \(sut.repos)")
        }

        // GitHubAPIの実行
                
//        StubGitHubAPIService.shared.searchContinuation?
//            .resume(returning: Repo.sampleData)
//        StubGitHubAPIService.shared.searchContinuation = nil
        await search
        sut.cancelSearching()
        _ = await sut.task?.result  // searchButtonPressed()内のTask内の処理を待つ
        
        // then
        // 検索後の状態の確認
        switch sut.repos {
        case .idle:
            break
        default:
//            XCTFail("unexpected repos: \(sut.repos)")
            break
        }
    }
     */

    // MARK: 成功
    @MainActor
    func testSearchReposButtonPressedSuccess() async {
        // given
        // when
        sut.keyword = "swift"
        async let search: Void = sut.searchButtonPressed()
        while GitHubAPIClientStub.shared.searchContinuation == nil {
            await Task.yield()
        }

        // then
        // 検索中の状態になっているかの確認
        switch sut.repos {
        case .loading:
            break
        default:
            XCTFail("unexpected repos: \(sut.repos)")
        }

        // GitHubAPIの実行
        GitHubAPIClientStub.shared.searchContinuation?
            .resume(returning: Repo.sampleData)
        GitHubAPIClientStub.shared.searchContinuation = nil
        await search
        _ = await sut.task?.result  // searchButtonPressed()内のTask内の処理を待つ

        // 検索後の状態の確認
        switch sut.repos {
        case let .loaded(repos):
            XCTAssertFalse(repos.isEmpty)
        default:
            XCTFail("unexpected repos: \(sut.repos)")
        }
    }

    // MARK: Helpers
    @MainActor
    private func searchReposFail(withError error: Error) async {
        // given
        // when
        sut.keyword = "swift"
        async let search: Void = sut.searchButtonPressed()
        while GitHubAPIClientStub.shared.searchContinuation == nil {
            await Task.yield()
        }
        GitHubAPIClientStub.shared.searchContinuation?
            .resume(throwing: error)
        GitHubAPIClientStub.shared.searchContinuation = nil
        await search
        _ = await sut.task?.result  // searchButtonPressed()内のTask内の処理を待つ
    }
    
    // MARK: 通信エラー
    @MainActor
    func testSearchReposButtonPressedFailByConnectionError() async {
        // given/when
        await searchReposFail(
            withError:
                GitHubAPIClientError.connectionError(MessageError(description: "(Debug) .connectionErrror"))
        )
        // then
        switch sut.repos {
        case .failed:
            break
        default:
            XCTFail("unexpected repos: \(sut.repos)")
        }
    }

    // MARK: レスポンスの文字列のデコードエラー
    @MainActor
    func testSearchReposButtonPressedFailByResponseParseErrorError() async {
        // given/when
        await searchReposFail(
            withError:
                GitHubAPIClientError.responseParseError(MessageError(description: "(Debug) .connectionErrror"))
        )
        // then
        switch sut.repos {
        case .failed:
            break
        default:
            XCTFail("unexpected repos: \(sut.repos)")
        }
    }
    
    // MARK: GitHubAPIで返されたエラー
    @MainActor
    func testSearchReposButtonPressedFailByAPIError() async {
        // given/when
        await searchReposFail(
            withError:
                GitHubAPIClientError.apiError(GitHubAPIError.sampleData[0])
        )
        // then
        switch sut.repos {
        case .failed:
            break
        default:
            XCTFail("unexpected repos: \(sut.repos)")
        }
    }
    
    // MARK: その他のエラー
    @MainActor
    func testSearchReposButtonPressedFailByOtherError() async {
        // given/when
        await searchReposFail(
            withError:
                MessageError(description: "(Debug) error")
        )
        // then
        switch sut.repos {
        case .failed:
            break
        default:
            XCTFail("unexpected repos: \(sut.repos)")
        }
    }

}
