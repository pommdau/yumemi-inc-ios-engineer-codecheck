//
//  RepositoryListView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepositoryListView: View {

    @State private var repositories = ["repo1", "repo2", "repo3"]
    @State private var keyword = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(repositories, id: \.self) { repository in
                    NavigationLink {
                        Text(repository)
                    } label: {
                        HStack {
                            Text("<user>/\(repository)")
                            Spacer()
                            Text("<language>")
                        }
                    }
                }
            }
        }
        .searchable(text: $keyword,
                    placement: .automatic,
                    prompt: "GitHubのリポジトリを検索") {
        }
        .onSubmit(of: .search) {
            repositories.append("new result")
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
    }
}
