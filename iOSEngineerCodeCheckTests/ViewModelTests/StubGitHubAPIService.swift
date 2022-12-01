//
//  StubSearchRepositories.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/11/27.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

final class StubGitHubAPIService: GitHubAPIServiceProtocol {

    static let shared: StubGitHubAPIService = .init()

    var searchContinuation: CheckedContinuation<[Repository], Error>?

    private init() {}

    func searchRepositories(keyword: String) async throws -> [Repository] {
        try await withCheckedThrowingContinuation { continuation in
            searchContinuation = continuation
        }
    }
}
