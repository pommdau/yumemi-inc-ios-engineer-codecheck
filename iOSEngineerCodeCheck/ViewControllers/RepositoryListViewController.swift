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
    var repositories: [[String: Any]] = []
    var task: URLSessionTask?
    var selectedRow: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        // 検索フィールドの初期化
        // TODO: Placeholderへの置き換え
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // フォーカス時にテキストをクリアする
        // TODO: Placeholderへの置き換え
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard
            let searchingWord = searchBar.text,
            !searchingWord.isEmpty,
            let searchingUrl = URL(string: "https://api.github.com/search/repositories?q=\(searchingWord)")
        else {
            return
        }

        task = URLSession.shared.dataTask(with: searchingUrl) { data, _, _ in
            do {
                guard
                    let data = data,
                    let response = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let items = response["items"] as? [[String: Any]]
                else {
                    return
                }
                self.repositories = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                // TODO: Add Error Handling
            }
        }
        // 通信の開始
        task?.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            guard let dtl = segue.destination as? RepositoryDetailViewController else {
                return
            }
            dtl.repositoryListViewController = self
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = repositories[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        selectedRow = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
}
