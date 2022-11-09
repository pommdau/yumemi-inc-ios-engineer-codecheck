//
//  RepositoryListViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryListViewController: UITableViewController {

    // MARK: - Properties

    @IBOutlet private weak var searchBar: UISearchBar!
    private var viewModel: RepositoryListViewModel = .init()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // 検索フィールドの初期化
        // TODO: Placeholderへの置き換え
        searchBar.text = "github"
        searchBar.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showDetailView {
            guard let detailViewController = segue.destination as? RepositoryDetailViewController,
                  let repository = viewModel.selectedRepository
            else {
                assertionFailure()
                return
            }
            detailViewController.viewModel = RepositoryDetailViewModel(repository: repository)
        }
    }
}

// MARK: - UITableViewDelegate/DataSource

extension RepositoryListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.createCell(tableView, cellForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        viewModel.tableViewDidSelectedRowAt(indexPath: indexPath)
        performSegue(withIdentifier: SegueIdentifier.showDetailView, sender: self)
    }
}

// MARK: - UISearchBarDelegate

extension RepositoryListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarTextDidChange()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task.detached {
            do {
                try await self.viewModel.searchBarSearchButtonClicked(keyword: searchBar.text)
                Task { @MainActor in
                    self.tableView.reloadData()
                }
            } catch {
                await UIAlertController.showAlert(viewController: self, title: "検索エラー", message: error.localizedDescription)
                return
            }
        }
    }
}
