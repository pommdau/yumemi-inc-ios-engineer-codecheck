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

struct RepositoryDetailView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            RepositoryDetailScreen(repository: Repository.sampleData[0])
            RepositoryDetailScreen(repository: Repository.sampleData[1])
        }
    }
}
