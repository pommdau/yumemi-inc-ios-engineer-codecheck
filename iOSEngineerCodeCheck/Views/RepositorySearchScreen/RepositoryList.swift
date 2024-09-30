//
//  RepositoryListView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/12/01.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepositoryList: View {

    let repositories: [Repository]    

    var body: some View {
        if repositories.isEmpty {
            Text("該当するリポジトリが見つかりませんでした")
                .fontWeight(.bold)
        } else {
            List(repositories) { repository in
                NavigationLink {
                    RepositoryDetailScreen(repository: repository)
                } label: {
                    RepositoryCell(repository: repository)
                }
            }
        }
    }
}

// MARK: - Previews

#Preview("通常") {
    NavigationView {
        RepositoryList(repositories: Repository.sampleData)
    }
}

#Preview("検索結果が空") {
    NavigationView {
        RepositoryList(repositories: [])
    }
}
