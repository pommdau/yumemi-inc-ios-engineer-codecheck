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
        let data = SearchResponse<Repository>.sampleJSON.data(using: .utf8)!
        let response = try jsonDecoder.decode(SearchResponse<Repository>.self, from: data)
        
        XCTAssertEqual(response.totalCount, 141722)
        XCTAssertEqual(response.items.count, 3)
        
        let firstRepository = response.items.first
        XCTAssertEqual(firstRepository?.name, "swift")
        XCTAssertEqual(firstRepository?.fullName, "apple/swift")
    }
    
}
