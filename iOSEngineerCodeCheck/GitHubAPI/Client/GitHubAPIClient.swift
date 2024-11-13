//
//  GitHubAPIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/27.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

final actor GitHubAPIClient: GitHubAPIClientProtocol {

    static let shared: GitHubAPIClient = .init()
    
    private(set) var urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func searchRepos(keyword: String) async throws -> [Repo] {
#if DEBUG
        // wanring:型パラメータインジェクションによるDIのため、ViewModelの外からのテストでStubを使えていない
        // UITestでもうまくStubを遣う方法を考えたい
        if ProcessInfo.processInfo.arguments.contains("-MockGitHubAPIService") {
            return Repo.sampleData
        }
#endif
        let response = try await request(with: GitHubAPIRequest.SearchRepos(keyword: keyword))
        let repos = response.items

        // リポジトリの詳細情報を取得して情報を追加する(RateLimitに注意)
//        let details = try await fetchReposDetails(withRepositories: repos)
//        for index in details.indices {
//            repos[index].update(withRepositoryDetail: details[index])
//        }

        return repos
    }
}

extension GitHubAPIClient {
    /// すぐにAPI制限に引っかかってしまうため、必要なときになって初めて呼び出す工夫が必要
    func fetchRepoDetails(_ repos: [Repo]) async throws -> [RepoDetail] {
        try await withThrowingTaskGroup(of: RepoDetail.self) { group in
            for repo in repos {
                group.addTask {
                    try await self.fetchRepoDetail(userName: repo.owner.name,
                                                   repoName: repo.name)
                }
            }

            var repoDetailsList: [RepoDetail] = []
            for try await repoDetails in group {
                repoDetailsList.append(repoDetails)
            }
            
            return repoDetailsList
        }
    }

    private func fetchRepoDetail(userName: String, repoName: String) async throws -> RepoDetail {
        let response = try await request(with: GitHubAPIRequest.GetRepoDetails(userName: userName, repoName: repoName))
        return response
    }
}
