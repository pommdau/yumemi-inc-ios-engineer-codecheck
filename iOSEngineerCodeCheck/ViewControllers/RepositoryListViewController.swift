//
//  RepositoryListViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryListViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet private weak var searchBar: UISearchBar!
    var repositories: [Repository] = []
    var task: URLSessionTask?
    var selectedRow: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        // 検索フィールドの初期化
        // TODO: Placeholderへの置き換え
        searchBar.text = "github"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // フォーカス時にテキストをクリアする
        // TODO: Placeholderへの置き換え
        //        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text,
              !keyword.isEmpty
        else {
            return
        }

        Task {
            do {
                let response = try await GitHubAPIService.SearchRepositories.shared.searchRepositories(keyword: keyword)
                self.repositories = response.items
                Task { @MainActor in
                    self.tableView.reloadData()
                }
            } catch {
                // TODO: add error handling
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            guard let detailViewController = segue.destination as? RepositoryDetailViewController,
                  selectedRow >= 0
            else {
                assertionFailure()
                return
            }
            detailViewController.viewModel = RepositoryDetailViewModel(repository: repositories[selectedRow])
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Repository") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Repository")
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName
        cell.detailTextLabel?.text = repository.language ?? ""
        cell.tag = indexPath.row

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        selectedRow = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
