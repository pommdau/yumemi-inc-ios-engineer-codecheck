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
                ProgressView("検索しています…")
            case .failed(let error):
                FailedView(error: error)
            case let .loaded(repositories):
                RepositoryList(repositories: repositories)
            }
        }
        .onChange(of: isSearching) { newValue in
            if !newValue {
                // 検索がキャンセルされた場合
                viewModel.cancelSearching()
            }
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(viewModel: .init())
    }
}
