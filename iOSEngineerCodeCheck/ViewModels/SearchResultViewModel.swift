//
//  SearchResultViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

@MainActor
final class SearchResultViewModel<GitHubAPIService>: ObservableObject
where GitHubAPIService: GitHubAPIServiceProtocol {
    
    // FIXME: private(set)したいがUITest用にpublicにしてしまっている状態
    // ViewModelのProtocolを定義して対応する？
    @Published var repositories: Stateful<[Repository]> = .idle
    private(set) var task: Task<(), Never>?
}

// MARK: - Handle Searching Methods

extension SearchResultViewModel {

    func cancelSearching() {
        task?.cancel()
        task = nil
    }

    func searchButtonPressed(withKeyword keyword: String) async {
        if keyword.isEmpty {
            return
        }
        repositories = .loading
        task = Task {
            do {
                let repositories = try await searchRepositories(keyword: keyword)
                self.repositories = .loaded(repositories)
            } catch {
                if Task.isCancelled {
                    repositories = .idle
                } else {
                    repositories = .failed(error)
                }
            }
        }
    }

    // サブスレッドで実行させるためnoisolatedを使用する
    nonisolated private func searchRepositories(keyword: String) async throws -> [Repository] {
        #if DEBUG
        //        try await Task.sleep(nanoseconds: 3 * NSEC_PER_SEC)  // n秒待つ。検索キャンセル処理の動作確認用。
        #endif
        return try await GitHubAPIService.shared.searchRepositories(keyword: keyword)
    }
}
