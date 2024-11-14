//
//  RepoList.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/12/01.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepoList: View {

    let repos: [Repo]    

    var body: some View {
        if repos.isEmpty {
            Text(R.string.localizable.repositorySearchScreenRepoListNoRepositoryText())
                .fontWeight(.bold)
        } else {
            List(repos) { repo in
                NavigationLink {
                    RepoDetailsScreen(repo: repo)
                } label: {
                    RepoCell(repo: repo)
                }
            }
        }
    }
}

// MARK: - Previews

#Preview("通常") {
    NavigationView {
        RepoList(repos: Repo.sampleData)
    }
}

#Preview("検索結果が空") {
    NavigationView {
        RepoList(repos: [])
    }
}
