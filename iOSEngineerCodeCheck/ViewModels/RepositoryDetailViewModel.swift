//
//  RepositoryDetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

struct RepositoryDetailViewModel {

    // MARK: - Properties

    let repository: Repository

    var titleText: String {
        repository.fullName
    }

    var starsText: String {
        "\(repository.starsCount) stars"
    }

    var watchersText: String {
        "\(repository.watchersCount) watchers"
    }

    var forksText: String {
        "\(repository.forksCount) forks"
    }

    var issuesText: String {
        "\(repository.openIssuesCount) open issues"
    }

    var languageText: String {
        if let language = repository.language {
            return "Written in \(language)"
        } else {
            return "(not specified language)"
        }
    }

    private var avatarImageURL: URL? {
        URL(string: repository.owner.avatarImagePath)
    }

    // MARK: Functions

    func downloadAvatarImage() async throws -> UIImage? {
        guard let avatarImageURL = avatarImageURL else {
            assertionFailure()
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: avatarImageURL)
        return UIImage(data: data)
    }

}
