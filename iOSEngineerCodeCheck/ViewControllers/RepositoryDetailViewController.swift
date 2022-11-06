//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!

    var repositoryListViewController: RepositoryListViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        let repo = repositoryListViewController.repositories[repositoryListViewController.selectedRow]
        languageLabel.text = "Written in \(repo["language"] as? String ?? "")"
        starsLabel.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }

    func getImage() {
        let repo = repositoryListViewController.repositories[repositoryListViewController.selectedRow]
        if let title = repo["full_name"] as? String {
            titleLabel.text = title
        }

        guard let owner = repo["owner"] as? [String: Any],
              let avatarImagePath = owner["avatar_url"] as? String,
              let avatarImageURL = URL(string: avatarImagePath)
        else {
            return
        }        
        URLSession.shared.dataTask(with: avatarImageURL) { data, _, _ in
            guard let data = data,
                  let avatarImage = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = avatarImage
            }
        }
        .resume()
    }
}
