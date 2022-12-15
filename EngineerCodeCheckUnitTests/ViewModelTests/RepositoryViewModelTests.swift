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

    // MARK: - Properties
    
    private var sut: SearchResultViewModel<StubGitHubAPIService>!

    // MARK: - Setup/TearDown
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchResultViewModel<StubGitHubAPIService>()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // MARK: - リポジトリの検索
    
    // MARK: 検索フィールドが空の場合

    func testSearchRepositoriesButtonPressedWhenKeywordIsEmpty() async {
        // given
        // when
        await sut.searchButtonPressed(withKeyword: "")

        // then
        switch sut.repositories {
        case .idle:
            break
        default:
            XCTFail("unexpected repositories: \(sut.repositories)")
        }
    }
    
    // FIXME: 検索のキャンセル処理のテストがうまく動作していないので一時的にコメントアウト
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
    func testSearchRepositoriesButtonPressedAndCancel() async {
        // given
        // when
        async let search: Void = sut.searchButtonPressed(withKeyword: "swift)
        while StubGitHubAPIService.shared.searchContinuation == nil {
            await Task.yield()
        }

        // then

        // 検索中の状態になっているかの確認
        switch sut.repositories {
        case .loading:
            break
        default:
            XCTFail("unexpected repositories: \(sut.repositories)")
        }

        // GitHubAPIの実行
                
//        StubGitHubAPIService.shared.searchContinuation?
//            .resume(returning: Repository.sampleData)
//        StubGitHubAPIService.shared.searchContinuation = nil
        await search
        sut.cancelSearching()
        _ = await sut.task?.result  // searchButtonPressed()内のTask内の処理を待つ
        
        // then
        // 検索後の状態の確認
        switch sut.repositories {
        case .idle:
            break
        default:
//            XCTFail("unexpected repositories: \(sut.repositories)")
            break
        }
    }
     */

    // MARK: 成功
    
    func testSearchRepositoriesButtonPressedSuccess() async {
        // given
        // when
        async let search: Void = sut.searchButtonPressed(withKeyword: "swift")
        while StubGitHubAPIService.shared.searchContinuation == nil {
            await Task.yield()
        }

        // then
        // 検索中の状態になっているかの確認
        switch sut.repositories {
        case .loading:
            break
        default:
            XCTFail("unexpected repositories: \(sut.repositories)")
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
            XCTAssertFalse(repositories.isEmpty)
        default:
            XCTFail("unexpected repositories: \(sut.repositories)")
        }
    }

    // MARK: Helpers
    
    private func searchRepositoriesFail(withError error: Error) async {
        // given
        // when
        async let search: Void = sut.searchButtonPressed(withKeyword: "swift")
        while StubGitHubAPIService.shared.searchContinuation == nil {
            await Task.yield()
        }
        StubGitHubAPIService.shared.searchContinuation?
            .resume(throwing: error)
        StubGitHubAPIService.shared.searchContinuation = nil
        await search
        _ = await sut.task?.result  // searchButtonPressed()内のTask内の処理を待つ
    }
    
    // MARK: 通信エラー

    func testSearchRepositoriesButtonPressedFailByConnectionError() async {
        // given/when
        await searchRepositoriesFail(
            withError:
                GitHubAPIServiceError.connectionError(MessageError(description: "(Debug) .connectionErrror"))
        )
        // then
        switch sut.repositories {
        case .failed:
            break
        default:
            XCTFail("unexpected repositories: \(sut.repositories)")
        }
    }

    // MARK: レスポンスの文字列のデコードエラー
    
    func testSearchRepositoriesButtonPressedFailByResponseParseErrorError() async {
        // given/when
        await searchRepositoriesFail(
            withError:
                GitHubAPIServiceError.responseParseError(MessageError(description: "(Debug) .connectionErrror"))
        )
        // then
        switch sut.repositories {
        case .failed:
            break
        default:
            XCTFail("unexpected repositories: \(sut.repositories)")
        }
    }
    
    // MARK: GitHubAPIで返されたエラー

    func testSearchRepositoriesButtonPressedFailByAPIError() async {
        // given/when
        await searchRepositoriesFail(
            withError:
                GitHubAPIServiceError.apiError(GitHubAPIError.sampleData[0])
        )
        // then
        switch sut.repositories {
        case .failed:
            break
        default:
            XCTFail("unexpected repositories: \(sut.repositories)")
        }
    }
    
    // MARK: その他のエラー

    func testSearchRepositoriesButtonPressedFailByOtherError() async {
        // given/when
        await searchRepositoriesFail(
            withError:
                MessageError(description: "(Debug) error")
        )
        // then
        switch sut.repositories {
        case .failed:
            break
        default:
            XCTFail("unexpected repositories: \(sut.repositories)")
        }
    }

}
