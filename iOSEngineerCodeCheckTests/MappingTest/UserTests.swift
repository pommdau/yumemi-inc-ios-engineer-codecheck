//
//  UserTests.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import XCTest
@testable import iOSEngineerCodeCheck

final class UserTests: XCTestCase {

    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = User.sampleJSON.data(using: .utf8)!
        let user = try jsonDecoder.decode(User.self, from: data)
        
        XCTAssertEqual(user.id, 15658638)
        XCTAssertEqual(user.name, "tensorflow")
        XCTAssertEqual(user.avatarImagePath, "https://avatars.githubusercontent.com/u/15658638?v=4")
        XCTAssertEqual(user.htmlPath, "https://github.com/tensorflow")
    }
    
}
