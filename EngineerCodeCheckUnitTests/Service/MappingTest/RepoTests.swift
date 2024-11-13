//
//  RepoTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/11/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import XCTest
@testable import iOSEngineerCodeCheck

final class RepoTests: XCTestCase {

    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        guard let data = Repo.sampleJSON.data(using: .utf8) else {
            XCTFail("jsonデータの取得に失敗しました")
            return
        }
        let repo = try jsonDecoder.decode(Repo.self, from: data)
        let user = repo.owner

        XCTAssertEqual(repo.id, 130902948)
        XCTAssertEqual(repo.name, "swift")
        XCTAssertEqual(repo.fullName, "tensorflow/swift")
        XCTAssertEqual(repo.starsCount, 6071)
        XCTAssertEqual(repo.watchersCount, 6071)
        XCTAssertEqual(repo.forksCount, 622)
        XCTAssertEqual(repo.openIssuesCount, 37)
        XCTAssertEqual(repo.language, "Jupyter Notebook")
        XCTAssertEqual(repo.htmlPath, "https://github.com/tensorflow/swift")
        XCTAssertEqual(repo.websitePath, "https://tensorflow.org/swift")
        XCTAssertEqual(repo.description, "Swift for TensorFlow")

        // User情報のデコード
        XCTAssertEqual(user.id, 15658638)
        XCTAssertEqual(user.name, "tensorflow")
        XCTAssertEqual(user.avatarImagePath, "https://avatars.githubusercontent.com/u/15658638?v=4")
        XCTAssertEqual(user.htmlPath, "https://github.com/tensorflow")
    }

}
