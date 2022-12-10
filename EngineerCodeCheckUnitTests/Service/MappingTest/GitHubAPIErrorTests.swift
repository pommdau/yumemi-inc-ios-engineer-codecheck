//
//  GitHubAPIErrorTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/11/25.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import XCTest
@testable import iOSEngineerCodeCheck

final class GitHubAPIErrorTests: XCTestCase {

    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        guard let data = GitHubAPIError.sampleJSON.data(using: .utf8) else {
            XCTFail("jsonデータの取得に失敗しました")
            return
        }
        let error = try jsonDecoder.decode(GitHubAPIError.self, from: data)

        XCTAssertEqual(error.message, "Validation Failed")

        guard let firstError = error.errors?.first else {
            XCTFail("エラーが存在しません")
            return
        }
        XCTAssertEqual(firstError?.resource, "Search")
        XCTAssertEqual(firstError?.field, "q")
        XCTAssertEqual(firstError?.code, "missing")
    }

}
