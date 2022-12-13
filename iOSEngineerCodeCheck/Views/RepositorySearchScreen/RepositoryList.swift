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

struct RepositoryList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                RepositoryList(repositories: Repository.sampleData)
            }
            .previewDisplayName("通常")

            NavigationView {
                RepositoryList(repositories: [])
            }
            .previewDisplayName("検索結果が空")
        }        
    }
}
