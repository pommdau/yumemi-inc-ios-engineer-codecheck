//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!

    // MARK: - Properties

    var repository: Repository?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Helpers

    private func configureUI() {
        guard let repository = repository else {
            assertionFailure()
            return
        }
        starsLabel.text = "\(repository.starsCount) stars"
        watchersLabel.text = "\(repository.watchersCount) watchers"
        forksLabel.text = "\(repository.forksCount) forks"
        issuesLabel.text = "\(repository.openIssuesCount) open issues"
        if let language = repository.language {
            languageLabel.text = "Written in \(language)"
        } else {
            languageLabel.text = "(not specified language)"
        }
        getImage()
    }

    func getImage() {
        guard let repository = repository else {
            assertionFailure()
            return
        }
        titleLabel.text = repository.fullName
        guard let avatarImageURL = URL(string: repository.owner.avatarImagePath) else {
            return
        }
        URLSession.shared.dataTask(with: avatarImageURL) { data, _, _ in
            guard let data = data,
                  let avatarImage = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else {
                    return
                }
                self.imageView.image = avatarImage
            }
        }
        .resume()
    }
}
