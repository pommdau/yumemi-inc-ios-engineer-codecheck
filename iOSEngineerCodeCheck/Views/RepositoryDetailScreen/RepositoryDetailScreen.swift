//
//  RepositoryDetailScreen.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepositoryDetailScreen: View {

    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            TitleView(repository: repository)
            Divider()
            AboutView(repository: repository)
            if let language = repository.language,
               !language.isEmpty {
                Divider()
                LanguageView(language: language)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Previews

#Preview("通常") {
    RepositoryDetailScreen(repository: Repository.sampleData[0])
}

#Preview("長い語句を含む場合") {
    RepositoryDetailScreen(repository: Repository.sampleDataWithLongWord)
}

#Preview("空の情報がある場合") {
    RepositoryDetailScreen(repository: Repository.sampleDataWithoutSomeInfo)
}
