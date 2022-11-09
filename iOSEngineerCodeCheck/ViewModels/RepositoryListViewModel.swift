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

    private(set) var repositories: [Repository] = []
    private var task: URLSessionTask?
    private var selectedRow: Int = -1

    var selectedRepository: Repository? {
        guard
            selectedRow >= 0,
            selectedRow <= repositories.count - 1
        else {
            return nil
        }
        return repositories[selectedRow]
    }
}

// MARK: - UITableView Methods

extension RepositoryListViewModel {
    func tableViewDidSelectedRowAt(indexPath: IndexPath) {
        selectedRow = indexPath.row
    }

    func createCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Repository") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Repository")
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName
        cell.detailTextLabel?.text = repository.language ?? ""
        cell.tag = indexPath.row

        return cell
    }
}

// MARK: - UISearchBar Methods

extension RepositoryListViewModel {

    func searchBarTextDidChange() {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(keyword: String?) async throws {
        guard let keyword,
              !keyword.isEmpty else {
            return
        }
        let response = try await GitHubAPIService.SearchRepositories.shared.searchRepositories(keyword: keyword)
        repositories = response.items
    }

}
