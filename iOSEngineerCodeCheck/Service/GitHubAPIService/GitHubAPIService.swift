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
    
    // FIXME: できればUnitTest用のURLSessionは公開したくない
    
    private(set) var urlSession: URLSessionProtocol = URLSession.shared
    
    func setURLSession(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }

    func searchRepositories(keyword: String) async throws -> [Repository] {
#if DEBUG
        // UITest用
        // TODO: 型パラメータインジェクションを採用したためStubを使えていない状態。
        // UITestでもうまくStubを遣う方法を考えたい
        if ProcessInfo.processInfo.arguments.contains("-MockGitHubAPIService") {
            return Repository.sampleData
        }
#endif
        let response = try await request(with: GitHubAPIRequest.SearchRepositories(keyword: keyword))
        let repositories = response.items

        // TODO: RateLimitに注意
        // リポジトリの詳細情報を取得して情報を追加する
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
