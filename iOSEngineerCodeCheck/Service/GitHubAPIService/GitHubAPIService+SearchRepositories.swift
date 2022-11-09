//
//  GitHubAPIService+SearchRepositories.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

extension GitHubAPIService {

    final actor SearchRepositories: GitHubAPIServiceProtocol {

        static let shared: SearchRepositories = .init()

        func searchRepositories(keyword: String) async throws -> GitHubAPIRequest.SearchRepositories.Response {
            let response = try await request(with: GitHubAPIRequest.SearchRepositories(keyword: keyword))
            return response
        }
    }
}
