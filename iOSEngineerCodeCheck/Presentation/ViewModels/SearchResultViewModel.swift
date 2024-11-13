//
//  SearchResultViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

@MainActor
@Observable
final class SearchResultViewModel<GitHubAPIClient>
where GitHubAPIClient: GitHubAPIClientProtocol {
    var keyword: String = ""
    private(set) var state: ViewState<[Repo]>
    private(set) var task: Task<(), Never>?
    
    init(repos: ViewState<[Repo]> = .idle([])) {
        self.state = repos
    }
}

// MARK: - Handle Searching Methods

extension SearchResultViewModel {

    func cancelSearching() {
        task?.cancel()
        task = nil
    }

    func searchButtonPressed() async {
        if keyword.isEmpty {
            return
        }
        state = .loading
        task = Task {
            do {
                let repos = try await searchRepos(keyword: keyword)
                self.state = .loaded(repos)
            } catch {
                if Task.isCancelled {
                    state = .idle([])
                } else {
                    state = .failed(error)
                }
            }
        }
    }

    // noisolated: APIClientの処理がサブスレッドで実行されるため
    nonisolated private func searchRepos(keyword: String) async throws -> [Repo] {
        #if DEBUG
        //        try await Task.sleep(nanoseconds: 3 * NSEC_PER_SEC)  // n秒待つ。検索キャンセル処理の動作確認用。
        #endif
        return try await GitHubAPIClient.shared.searchRepos(keyword: keyword)
    }
}
