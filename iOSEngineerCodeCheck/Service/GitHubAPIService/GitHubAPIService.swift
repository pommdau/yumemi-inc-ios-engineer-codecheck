//
//  GitHubAPIService.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/27.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

final actor GitHubAPIService: GitHubAPIServiceProtocol {
   
    static let shared: GitHubAPIService = .init()
        
    func searchRepositories(keyword: String) async throws -> [Repository] {
        let response = try await request(with: GitHubAPIRequest.SearchRepositories(keyword: keyword))
        let repositories = response.items
        
        /* TODO: API制限に引っかかってしまうため、別の方法で代替すること
        // リポジトリの詳細情報を取得して情報を追加する
        let details = try await FetchRepositoryDetail.shared.fetchRepositoryDetails(withRepositories: repositories)
        for (index, _) in details.enumerated() {
            repositories[index].update(withRepositoryDetail: details[index])
        }
         */
        
        return repositories
    }
}
