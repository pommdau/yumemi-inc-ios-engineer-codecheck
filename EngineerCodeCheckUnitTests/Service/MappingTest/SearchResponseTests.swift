//
//  SearchResponseTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/11/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import XCTest
@testable import iOSEngineerCodeCheck

final class SearchResponseTests: XCTestCase {

    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        guard let data = SearchResponse<Repo>.sampleJSON.data(using: .utf8) else {
            XCTFail("jsonデータの取得に失敗しました")
            return
        }
        let response = try jsonDecoder.decode(SearchResponse<Repo>.self, from: data)

        XCTAssertEqual(response.totalCount, 141722)
        XCTAssertEqual(response.items.count, 3)

        let firstRepo = response.items.first
        XCTAssertEqual(firstRepo?.name, "swift")
        XCTAssertEqual(firstRepo?.fullName, "apple/swift")
    }

}
