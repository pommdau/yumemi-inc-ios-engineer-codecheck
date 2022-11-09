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

    var viewModel: RepositoryDetailViewModel?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Helpers

    private func configureUI() {
        guard let viewModel else {
            assertionFailure()
            return
        }
        starsLabel.text = viewModel.starsText
        watchersLabel.text = viewModel.watchersText
        forksLabel.text = viewModel.forksText
        issuesLabel.text = viewModel.issuesText
        languageLabel.text = viewModel.languageText
        titleLabel.text = viewModel.titleText

        Task.detached { [weak self] in
            guard let self else {
                return
            }
            let avatarImage = try await viewModel.downloadAvatarImage()
            Task { @MainActor in
                self.imageView.image = avatarImage
            }
        }
    }
}
