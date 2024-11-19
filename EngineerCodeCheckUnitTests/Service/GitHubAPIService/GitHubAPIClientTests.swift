//
//  GitHubAPIClientTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/12/01.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
import HTTPTypes
@testable import iOSEngineerCodeCheck

final class GitHubAPIClientTests: XCTestCase {
    
    // MARK: - Properties
        
    private var sut: GitHubAPIClient!

    // MARK: - Setup/TearDown
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: - リポジトリの検索
    // MARK: 成功

    func testSearchReposSuccess() async throws {
        // given
        guard let data = SearchResponse<Repo>.sampleJSON.data(using: .utf8) else {
            XCTFail("Stubデータの作成に失敗しました")
            return
        }
        let urlSessionStub = URLSessionStub(
            data: data,
            response: HTTPResponse(status: 200)
        )
        sut = GitHubAPIClient(urlSession: urlSessionStub)
                
        // when/then
        do {
            let repos = try await sut.searchRepos(keyword: "Swift")
            XCTAssertFalse(repos.isEmpty)
        } catch {
            XCTFail("unexpected error: \(error.localizedDescription)")
        }
    }
    
    // MARK: 通信エラー
    
    func testSearchReposFailByConnectionError() async throws {
        // given
        let urlSessionStub = URLSessionStub(
            error: URLError(.cannotConnectToHost)
        )
        sut = GitHubAPIClient(urlSession: urlSessionStub)
        
        // when
        var errorIsExpected = false
        do {
            _ = try await sut.searchRepos(keyword: "Swift")
        } catch {
            // then
            if let serviceError = error as? GitHubAPIClientError {
                switch serviceError {
                case .connectionError:
                    errorIsExpected = true
                default:
                    XCTFail("unexpected error: \(error.localizedDescription)")
                }
            } else {
                XCTFail("unexpected error: \(error.localizedDescription)")
            }
        }
        
        XCTAssert(errorIsExpected, "expected error is .connectionError")
    }
    
    // MARK: レスポンスの文字列のデコードエラー
    
    func testSearchReposFailByResponseParseError() async throws {
        // given
        let data = Data("{}".utf8) // ダミーのデータを渡す
        let urlSessionStub = URLSessionStub(
            data: data,
            response: HTTPResponse(status: 200)
        )
        sut = GitHubAPIClient(urlSession: urlSessionStub)
        
        // when
        var errorIsExpected = false
        do {
            _ = try await sut.searchRepos(keyword: "Swift")
        } catch {
            // then
            if let serviceError = error as? GitHubAPIClientError {
                switch serviceError {
                case .responseParseError:
                    errorIsExpected = true
                default:
                    XCTFail("unexpected error: \(error.localizedDescription)")
                }
            } else {
                XCTFail("unexpected error: \(error.localizedDescription)")
            }
        }
        
        XCTAssert(errorIsExpected, "expected error is .responseParseError")
    }
    
    // MARK: GitHubAPIで返されたエラー
    
    func testSearchReposFailByGitHubAPIError() async throws {
        // given
        guard let data = GitHubAPIError.sampleJSON.data(using: .utf8) else {
            XCTFail("Stubデータの作成に失敗しました")
            return
        }
        let urlSessionStub = URLSessionStub(
            data: data,
            response: HTTPResponse(status: 400)
        )
        sut = GitHubAPIClient(urlSession: urlSessionStub)
        
        // when
        var errorIsExpected = false
        do {
            _ = try await sut.searchRepos(keyword: "Swift")
        } catch {
            // then
            if let serviceError = error as? GitHubAPIClientError {
                switch serviceError {
                case .apiError:
                    errorIsExpected = true
                default:
                    XCTFail("unexpected error: \(error.localizedDescription)")
                }
            } else {
                XCTFail("unexpected error: \(error.localizedDescription)")
            }
        }
        
        XCTAssert(errorIsExpected, "Error is not expected.")
    }
}
