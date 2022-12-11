//
//  RepositorySearchScreen.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepositorySearchScreen: View {

    @StateObject private var viewModel: SearchResultViewModel<GitHubAPIService> = .init()
    internal let inspection = Inspection<Self>()

    var body: some View {
        NavigationView {
            // @Environment(\.isSearching) private var isSearching: Bool
            // 上記が.searchableと同じクラスでは使えず子Viewでしか使えないためクラスを分割している
            // TODO: ViewModelを複数クラスで使用するのは行儀の良くない気がする…
            SearchResultView(viewModel: viewModel)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.keyword,
                            placement: .automatic,
                            prompt: "検索") {
                }.onSubmit(of: .search) {
                    Task {
                        await viewModel.searchButtonPressed()
                    }
                }
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

struct RepositorySearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        RepositorySearchScreen()
    }
}
