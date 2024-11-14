//
//  GitHubLanguageColorManager.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/14.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//
// refs: https://raw.githubusercontent.com/ozh/github-colors/master/colors.json

import SwiftUI

struct LanguageRepository {

    // MARK: - Properties

    static let shared: LanguageRepository = .init()
    private let languages: [Language]

    // MARK: - LifeCycle

    private init() {
        guard let url = R.file.githubLangColorsJson(),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: [String: String?]]  // color: null があるためString?としている
        else {
            fatalError("Language設定ファイルの読み込みに失敗しました")
        }

        self.languages = json.map { name, details in
            let color = details["color"] as? String ?? "#000000"  // 未定義の場合は黒#000000とする
            return Language(name: name, hex: color)
        }
        .sorted(by: { first, second in
            first.name < second.name
        })
    }
    
    // MARK: - Read
    
    func fetch(name: String) -> Language? {
        guard let language = languages.first(where: { $0.name == name }) else {
            return nil
        }
        return language
    }
}
