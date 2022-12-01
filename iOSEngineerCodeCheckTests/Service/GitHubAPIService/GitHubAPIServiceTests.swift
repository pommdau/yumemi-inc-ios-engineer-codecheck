//
//  GitHubAPIServiceTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/12/01.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class GitHubAPIServiceTests: XCTestCase {
    
    private var sut: GitHubAPIService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = GitHubAPIService()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testSearchRepositotiesSuccess() async throws {
        // given
        guard let data = SearchResponse<Repository>.sampleJSON.data(using: .utf8),
              let url = URL(string: "https://api.github.com/search/repositories?q=Swift")
        else {
            XCTFail("Stubデータの作成に失敗しました")
            return
        }
        let urlSessionStub = StubURLSession(
            data: data,
            response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        )
        await sut.setURLSession(urlSession: urlSessionStub)
                
        // when/then
        do {
            let repositories = try await sut.searchRepositories(keyword: "Swift")
            XCTAssertFalse(repositories.isEmpty)
        } catch {
            XCTFail("unexpected error: \(error.localizedDescription)")
        }
    }
    
    func testSearchRepositotiesFailByConnectionError() async throws {
        // given
        let urlSessionStub = StubURLSession(
            error: URLError(.cannotConnectToHost)
        )
        await sut.setURLSession(urlSession: urlSessionStub)
        
        // when
        var errorIsExpected = false
        do {
            _ = try await sut.searchRepositories(keyword: "Swift")
        } catch {
            // then
            if let serviceError = error as? GitHubAPIServiceError {
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
    
    func testSearchRepositotiesFailByResponseParseError() async throws {
        // given
        guard let data = "{}".data(using: .utf8),  // ダミーのデータを渡す
              let url = URL(string: "https://api.github.com/search/repositories?q=Swift")
        else {
            XCTFail("Stubデータの作成に失敗しました")
            return
        }
        let urlSessionStub = StubURLSession(
            data: data,
            response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        )
        await sut.setURLSession(urlSession: urlSessionStub)
        
        // when
        var errorIsExpected = false
        do {
            _ = try await sut.searchRepositories(keyword: "Swift")
        } catch {
            // then
            if let serviceError = error as? GitHubAPIServiceError {
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
    
    func testSearchRepositotiesFailByGitHubAPIError() async throws {
        // given
        guard let data = GitHubAPIError.sampleJSON.data(using: .utf8),
              let url = URL(string: "https://api.github.com/search/repositories?q=Swift")
        else {
            XCTFail("Stubデータの作成に失敗しました")
            return
        }
        let urlSessionStub = StubURLSession(
            data: data,
            response: HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
        )
        await sut.setURLSession(urlSession: urlSessionStub)
        
        // when
        var errorIsExpected = false
        do {
            _ = try await sut.searchRepositories(keyword: "Swift")
        } catch {
            // then
            if let serviceError = error as? GitHubAPIServiceError {
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
