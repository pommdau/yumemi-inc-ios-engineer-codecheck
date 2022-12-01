//
//  RepositoryTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/11/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import XCTest
@testable import iOSEngineerCodeCheck

final class RepositoryTests: XCTestCase {

    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        guard let data = Repository.sampleJSON.data(using: .utf8) else {
            XCTFail("jsonデータの取得に失敗しました")
            return
        }
        let repository = try jsonDecoder.decode(Repository.self, from: data)
        let user = repository.owner

        XCTAssertEqual(repository.id, 130902948)
        XCTAssertEqual(repository.name, "swift")
        XCTAssertEqual(repository.fullName, "tensorflow/swift")
        XCTAssertEqual(repository.starsCount, 6071)
        XCTAssertEqual(repository.watchersCount, 6071)
        XCTAssertEqual(repository.forksCount, 622)
        XCTAssertEqual(repository.openIssuesCount, 37)
        XCTAssertEqual(repository.language, "Jupyter Notebook")
        XCTAssertEqual(repository.htmlPath, "https://github.com/tensorflow/swift")
        XCTAssertEqual(repository.websitePath, "https://tensorflow.org/swift")
        XCTAssertEqual(repository.description, "Swift for TensorFlow")

        // User情報のデコード
        XCTAssertEqual(user.id, 15658638)
        XCTAssertEqual(user.name, "tensorflow")
        XCTAssertEqual(user.avatarImagePath, "https://avatars.githubusercontent.com/u/15658638?v=4")
        XCTAssertEqual(user.htmlPath, "https://github.com/tensorflow")
    }

}
