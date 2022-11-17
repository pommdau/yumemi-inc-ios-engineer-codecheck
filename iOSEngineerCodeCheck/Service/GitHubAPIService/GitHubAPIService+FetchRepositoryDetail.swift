//
//  GitHubAPIService+FetchRepositoryDetail.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

extension GitHubAPIService {
    
    final actor FetchRepositoryDetail: GitHubAPIServiceProtocol {
        
        static let shared: FetchRepositoryDetail = .init()
        
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
            let response = try await request(with: GitHubAPIRequest.GetRepositoryDetail.init(userName: userName,
                                                                                             repositoryName: repositoryName))
            return response
        }
    }
}
