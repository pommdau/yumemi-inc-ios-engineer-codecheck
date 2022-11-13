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
    @Published private(set) var repositories: [Repository] = Repository.sampleData
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
        let response = try await GitHubAPIService.SearchRepositories.shared.searchRepositories(keyword: keyword)
        repositories = response.items
    }

}
