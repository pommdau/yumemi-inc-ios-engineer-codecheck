//
//  SearchResultView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/15.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct SearchResultView: View {

    // isSearchingは.searchableと同じViewで使用できないため、本Viewを切り出している
    @Environment(\.isSearching)
    private var isSearching: Bool
    
    @State var viewModel: SearchResultViewModel<GitHubAPIService>
    internal let inspection = Inspection<Self>()

    var body: some View {
        Group {
            switch viewModel.repositories {
            case .idle:
                ReadyView()
            case .loading:
                RepositoryListSkelton()
            case .failed(let error):
                FailedView(error: error)
            case let .loaded(repositories):
                RepositoryList(repositories: repositories)
            }
        }
        .onChange(of: isSearching) { 
            if !isSearching {
                // 検索がキャンセルされた場合
                viewModel.cancelSearching()
            }
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

// MARK: - Previews

#Preview {
    SearchResultView(viewModel: .init())
}
