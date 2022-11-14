//
//  RepositoryListView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepositoryListView: View {

    @State private var keyword = ""
    @StateObject private var viewModel: RepositoryListViewModel = .init()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repositories) { repository in
                    NavigationLink {
                        RepositoryDetailView(repository: repository)
                    } label: {
                        RepositoryListCell(repository: repository)
                    }
                }
            }
        }
        .searchable(text: $keyword,
                    placement: .automatic,
                    prompt: "GitHubのリポジトリを検索") {
        }
        .onSubmit(of: .search) {
            Task {
                do {
                    try await viewModel.searchButtonPressed(keyword: keyword)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
    }
}
