//
//  RepoSearchScreen.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

// INFO: Xcode16以上のビルドではViewに\@MainActorがつくので下記は不要となる
@MainActor
struct RepoSearchScreen: View {
    @State private var viewModel: SearchResultViewModel<GitHubAPIClient> = .init()
    @State private var searchSuggestionRepository = SearchSuggestionStore.shared
    internal let inspection = Inspection<Self>()
        
    var body: some View {
        NavigationView {
            SearchResultView(viewModel: viewModel)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.keyword, placement: .navigationBarDrawer, prompt: "検索")
                .searchSuggestions {
                    SearchSuggestionView()
                }
                .onSubmit(of: .search) {
                    searchSuggestionRepository.addHistory(viewModel.keyword)
                    Task {
                        await viewModel.searchButtonPressed()
                    }
                }
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

// MARK: - Previews

#Preview {
    RepoSearchScreen()
}
