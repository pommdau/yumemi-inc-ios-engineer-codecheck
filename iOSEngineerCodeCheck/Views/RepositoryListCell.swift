//
//  RepositoryListCell.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryListCell: UITableViewCell, NameDescribable {

    // MARK: - Properties

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!

    // MARK: - Helpers

    func configure(for repository: Repository) {
        titleLabel.text = repository.fullName
        languageLabel.text = repository.language
    }

}
