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

    @State private var viewModel: SearchResultViewModel<GitHubAPIService> = .init()
    @State private var keyword = ""
    internal let inspection = Inspection<Self>()

    var body: some View {
        NavigationView {
            SearchResultView(viewModel: viewModel)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $keyword,
                            placement: .automatic,
                            prompt: "検索") {
                }.onSubmit(of: .search) {
                    Task {
                        await viewModel.searchButtonPressed(withKeyword: keyword)
                    }
                }
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

// MARK: - Previews

#Preview {
    RepositorySearchScreen()
}
