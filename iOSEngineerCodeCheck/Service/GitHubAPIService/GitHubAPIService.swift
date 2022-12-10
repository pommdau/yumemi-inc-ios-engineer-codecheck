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
