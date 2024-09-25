//
//  Danger.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2024/09/25.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Danger

let danger = Danger()

// SwiftLintの実行結果をインラインで表示
SwiftLint.lint(.modifiedAndCreatedFiles(directory: nil), inline: true)
