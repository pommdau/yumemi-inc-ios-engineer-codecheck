//
//  RepositoryListViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

@MainActor
final class RepositoryListViewModel: ObservableObject {
    @Published private(set) var repositories: Stateful<[Repository]> = .idle
    private var task: URLSessionTask?
}

// MARK: - Handle Searching Methods

extension RepositoryListViewModel {

    //    func searchBarTextDidChange() {
    //        task?.cancel()
    //    }

    func searchButtonPressed(keyword: String) async throws {
        guard !keyword.isEmpty else {
            return
        }
        repositories = .loading

        do {
            let repositories = try await searchRepositories(keyword: keyword)
            self.repositories = .loaded(repositories)
        } catch {
            self.repositories = .failed(error)
        }
    }

    // サブスレッドで実行させるためnoisolatedを使用する
    nonisolated private func searchRepositories(keyword: String) async throws -> [Repository] {
        try await GitHubAPIService.SearchRepositories.shared.searchRepositories(keyword: keyword)
    }
}
