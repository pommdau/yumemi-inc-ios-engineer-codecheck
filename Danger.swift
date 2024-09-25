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

// SwiftLintの結果を処理して、warning または error の場合にPRに表示
for violation in swiftLintViolations where violation.severity == .warning || violation.severity == .error {
    let message = "SwiftLint \(violation.severity.rawValue.capitalized): \(violation.reason) in \(violation.file):\(violation.line ?? 0)"
    
    if violation.severity == .warning {
        warning(message)
    } else if violation.severity == .error {
        fail(message)
    }
}
