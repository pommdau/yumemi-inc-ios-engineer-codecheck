//
//  SearchSuggestionView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2024/11/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct SearchSuggestionView: View {
    
    @State private var searchSuggestionRepository = SearchSuggestionStore.shared
    
    var body: some View {
        Section(R.string.localizable.generalSearch()) {
            if searchSuggestionRepository.historySuggestions.isEmpty {
                Text(R.string.localizable.repositorySearchScreenRepoSearchScreenNoHistory())
                    .foregroundStyle(.secondary)
            } else {
                ForEach(searchSuggestionRepository.historySuggestions, id: \.self) { history in
                    Label(history, systemImage: "clock")
                        .searchCompletion(history)
                        .foregroundStyle(.primary)
                    
                }
                Button(R.string.localizable.repositorySearchScreenRepoSearchScreenClearHistory()) {
                    searchSuggestionRepository.removeAllHistories()
                }
                .frame(alignment: .trailing)
            }
        }
        Section(R.string.localizable.repositorySearchScreenRepoSearchScreenRecommendation()) {
            ForEach(searchSuggestionRepository.recommendedSuggestions, id: \.self) { suggestion in
                Label(suggestion, systemImage: "magnifyingglass")
                    .searchCompletion(suggestion)
                    .foregroundStyle(.primary)
            }
        }
    }
}

#Preview() {
    List {
        SearchSuggestionView()
    }
}
