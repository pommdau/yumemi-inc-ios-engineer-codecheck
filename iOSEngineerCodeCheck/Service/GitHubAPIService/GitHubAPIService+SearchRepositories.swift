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

        func searchRepositories(keyword: String) async throws -> [Repository] {
            let response = try await request(with: GitHubAPIRequest.SearchRepositories(keyword: keyword))
            var repositories = response.items
            
            // リポジトリの詳細情報を取得して情報を追加する
            let details = try await GitHubAPIService.FetchRepositoryDetail.shared.fetchRepositoryDetails(withRepositories: repositories)
            for (index, _) in details.enumerated() {
                repositories[index].update(withRepositoryDetail: details[index])
            }
            
            return repositories
        }
    }
}
