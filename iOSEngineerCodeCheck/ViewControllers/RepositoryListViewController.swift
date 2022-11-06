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
    var searchingWord: String!
    var searchingUrlString: String!
    var selectedRow: Int!

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
        searchingWord = searchBar.text!
        if !searchingWord.isEmpty {
            searchingUrlString = "https://api.github.com/search/repositories?q=\(searchingWord!)"
            task = URLSession.shared.dataTask(with: URL(string: searchingUrlString)!) { data, _, _ in
                do {
                    if let obj = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                        if let items = obj["items"] as? [[String: Any]] {
                            self.repositories = items
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                } catch {
                    // TODO: Add error handling
                }
            }
            // 通信の開始
            task?.resume()
        }
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
