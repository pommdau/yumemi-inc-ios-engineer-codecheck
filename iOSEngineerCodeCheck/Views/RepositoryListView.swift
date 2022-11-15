//
//  RepositoryListView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepositoryListView: View {
    
    @StateObject private var viewModel = RepositoryListViewModel()
    
    var body: some View {
        NavigationView {
            // @Environment(\.isSearching) private var isSearching: Bool
            // 上記が.searchableと同じクラスでは使えず子Viewでしか使えないためクラスを分割している
            // TODO: ViewModelを複数クラスで使用するのは行儀の良くない気がする…
            RepositoryListSearchResultView(viewModel: viewModel)
                .navigationTitle("GitHubリポジトリ検索")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.keyword,
                            placement: .automatic,
                            prompt: "検索") {
                }.onSubmit(of: .search) {
                    Task {
                        do {
                            try await viewModel.searchButtonPressed()
                        } catch {
                            print(error.localizedDescription)
                        }
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
