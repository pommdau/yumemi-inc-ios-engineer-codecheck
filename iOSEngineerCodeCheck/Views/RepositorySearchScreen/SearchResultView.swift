//
//  SearchResultView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/15.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct SearchResultView: View {

    @Environment(\.isSearching) private var isSearching: Bool
    @StateObject var viewModel: RepositoryListViewModel<GitHubAPIService>

    var body: some View {
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
        .onChange(of: isSearching) { newValue in            
            // 検索が終了した場合
            if !newValue {
                viewModel.cancelSearching()
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
                if let serviceError = error as? GitHubAPIServiceError {
                    switch serviceError {
                    case .connectionError(let error):
                        Text(error.localizedDescription)
                    case .responseParseError(let error):
                        Text(error.localizedDescription)
                    case .apiError(let gitHubAPIError):
                        Text(gitHubAPIError.message)
                    }
                } else {
                    Text(error.localizedDescription)
                }
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
                    RepositoryDetailScreen(repository: repository)
                } label: {
                    RepositoryCell(repository: repository)
                }
            }
        }
    }
}

struct RepositoryListSearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(viewModel: .init())
    }
}
