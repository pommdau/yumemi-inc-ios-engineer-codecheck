//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Repository: Identifiable, Codable {
    // GitHubAPIService.SearchRepositoriesで取得される情報
    let id: Int
    let name: String  // e.g. "Tetris"
    let fullName: String  // e.g. "dtrupenn/Tetris"
    let owner: User
    let starsCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let language: String?
    
    // その他補完されて取得される情報
    var description: String?
    var subscribersCount: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case starsCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case language
    }
    
    mutating func update(withRepositoryDetail detail: RepositoryDetail) {
        self.description = detail.description
        self.subscribersCount = detail.subscribersCount
    }
}
