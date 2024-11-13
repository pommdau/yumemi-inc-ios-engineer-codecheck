//
//  RepoDetailsScreen.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepoDetailsScreen: View {

    let repo: Repo

    var body: some View {
        VStack(alignment: .leading) {
            TitleView(repo: repo)
            Divider()
            DescriptionView(repo: repo)
            if let language = repo.language,
               !language.isEmpty {
                Divider()
                LanguageView(languageName: language)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Previews

#Preview("通常") {
    RepoDetailsScreen(repo: Repo.sampleData[0])
}

#Preview("長い語句を含む場合") {
    RepoDetailsScreen(repo: Repo.sampleDataWithLongWord)
}

#Preview("空の情報がある場合") {
    RepoDetailsScreen(repo: Repo.sampleDataWithoutSomeInfo)
}
