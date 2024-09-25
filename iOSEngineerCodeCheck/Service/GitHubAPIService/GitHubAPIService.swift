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
    
    private(set) var urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func searchRepositories(keyword: String) async throws -> [Repository] {
#if DEBUG
        // wanring:型パラメータインジェクションによるDIのため、ViewModelの外からのテストでStubを使えていない
        // UITestでもうまくStubを遣う方法を考えたい
        if ProcessInfo.processInfo.arguments.contains("-MockGitHubAPIService") {
            return Repository.sampleData
        }
#endif
        let response = try await request(with: GitHubAPIRequest.SearchRepositories(keyword: keyword))
        let repositories = response.items

        // リポジトリの詳細情報を取得して情報を追加する(RateLimitに注意)
//        let details = try await fetchRepositoryDetails(withRepositories: repositories)
//        for index in details.indices {
//            repositories[index].update(withRepositoryDetail: details[index])
//        }

        return repositories
    }
}

extension GitHubAPIService {
    /// すぐにAPI制限に引っかかってしまうため、必要なときになって初めて呼び出す工夫が必要
    func fetchRepositoryDetails(withRepositories repositories: [Repository]) async throws -> [RepositoryDetail] {
        try await withThrowingTaskGroup(of: RepositoryDetail.self) { group in
            for repository in repositories {
                group.addTask {
                    try await self.fetchRepositoryDetail(userName: repository.owner.name,
                                                         repositoryName: repository.name)
                }
            }

            var repositoryDetails: [RepositoryDetail] = []
            for try await repositoryDetail in group {
                repositoryDetails.append(repositoryDetail)
            }
            
            return repositoryDetails
        }
    }

    private func fetchRepositoryDetail(userName: String, repositoryName: String) async throws -> RepositoryDetail {
        let response = try await request(with: GitHubAPIRequest.GetRepositoryDetail(userName: userName, repositoryName: repositoryName))
        return response
    }
}
