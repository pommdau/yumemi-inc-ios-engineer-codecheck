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
                ReadyView()
            case .loading:
                ProgressView("検索しています…")
            case .failed(let error):
                FailedView(error: error)
            case let .loaded(repositories):
                RepositoryList(repositories: repositories)
            }
        }
        .onChange(of: isSearching) { newValue in
            // 検索が終了した場合
            if !newValue {
                viewModel.cancelSearching()
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(viewModel: .init())
    }
}
