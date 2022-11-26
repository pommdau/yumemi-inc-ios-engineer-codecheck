//
//  GitHubLanguageColor.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/14.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct GitHubLanguageColor {

    // MARK: - Define

    private struct Language: Identifiable {
        let id = UUID()
        let name: String
        let color: Color

        /// e.g. hex = "#00cafe"
        init(name: String, hex: String) {
            self.name = name
            self.color = Color(hex: hex.replacingOccurrences(of: "#", with: ""))
        }
    }

    // MARK: - Properties

    static let shared: GitHubLanguageColor = .init()

    private let languages: [Language]

    // MARK: - LifeCycle

    private init() {
        // ref: https://raw.githubusercontent.com/ozh/github-colors/master/colors.json
        guard let url = Bundle.main.url(forResource: "github-lang-colors", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: [String: String?]]  // color: nullがあるためString?としている
        else {
            fatalError("github-lang-colors.jsonの読み込みに失敗しました。")
        }
        
        self.languages = json.map { name, details in
            let color = details["color"] as? String ?? "#000000"  // 未定義の場合は黒#000000とする
            return Language(name: name, hex: color)
        }
        .sorted(by: { first, second in
            first.name < second.name
        })
    }

    // MARK: - Public methods

    func getColor(withName name: String?) -> Color? {
        guard let name else {
            return nil
        }

        let language = languages.first { language in
            name == language.name
        }

        return language?.color
    }
}
