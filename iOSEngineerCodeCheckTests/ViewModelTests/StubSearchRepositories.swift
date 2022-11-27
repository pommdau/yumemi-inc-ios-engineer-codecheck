//
//  StubSearchRepositories.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/11/27.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

final class StubSearchRepositories: GitHubAPIServiceProtocol, SearchRepositoriesProtocol {

    static let shared: StubSearchRepositories = .init()
    
    var searchContinuation: CheckedContinuation<[Repository], Error>?
    
    private init() {}

    func search(keyword: String) async throws -> [Repository] {
        try await withCheckedThrowingContinuation { continuation in
            searchContinuation = continuation
        }
    }
}
