//
//  RepositorySearchScreen.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

// Xcode16以上のビルドではViewに\@MainActorがつくので下記は不要となる
@MainActor
struct RepositorySearchScreen: View {
    @State private var viewModel: SearchResultViewModel<GitHubAPIClient> = .init()
    @State private var searchSuggestionManager: SearchSuggestionManager = .init()
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        NavigationView {
            SearchResultView(viewModel: viewModel)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.keyword, placement: .navigationBarDrawer, prompt: "検索")
                .searchSuggestions {
                    searchSuggestions()
                }
                .onSubmit(of: .search) {
                    searchSuggestionManager.addHistory(viewModel.keyword)
                    Task {
                        await viewModel.searchButtonPressed()
                    }
                }
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

// MARK: - Search Suggestions

extension RepositorySearchScreen {
    @ViewBuilder
    private func searchSuggestions() -> some View {
        Section("履歴") {
            if searchSuggestionManager.historySuggestions.isEmpty {
                Text("(なし)")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(searchSuggestionManager.historySuggestions, id: \.self) { history in
                    Label(history, systemImage: "clock")
                        .searchCompletion(history)
                        .foregroundStyle(.primary)
                    
                }
                Button("履歴のクリア") {
                    searchSuggestionManager.removeAllHistories()
                }
                .frame(alignment: .trailing)
            }
        }
        Section("おすすめ") {
            ForEach(searchSuggestionManager.recommendedSuggestions, id: \.self) { suggestion in
                Label(suggestion, systemImage: "magnifyingglass")
                    .searchCompletion(suggestion)
                    .foregroundStyle(.primary)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    RepositorySearchScreen()
}
