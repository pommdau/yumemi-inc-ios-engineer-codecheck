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
            Group {
                switch viewModel.repositories {
                case .idle:
                    idledView()
                case .loading:
                    ProgressView("検索しています…")
                case .failed(let error):
                    failedView(error: error)
                case let .loaded(repositories):
                    loadedView(repositories: repositories)
                }
            }
            .navigationTitle("GitHubリポジトリ検索")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $keyword,
                    placement: .automatic,
                    prompt: "検索") {
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

    @ViewBuilder
    private func idledView() -> some View {
        VStack {
            Text("検索してみましょう")
                .font(.title)
                .bold()
                .padding()
            Text("GitHub内のリポジトリが検索できます")
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private func failedView(error: Error) -> some View {
        VStack {
            Group {
                Text("リポジトリの検索中にエラーが発生しました")
                    .padding(.bottom, 8)
                Text(error.localizedDescription)
            }
            .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private func loadedView(repositories: [Repository]) -> some View {
        if repositories.isEmpty {
            Text("該当するリポジトリが見つかりませんでした")
                .fontWeight(.bold)
        } else {
            List(repositories) { repository in
                NavigationLink {
                    RepositoryDetailView(repository: repository)
                } label: {
                    RepositoryListCell(repository: repository)
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
