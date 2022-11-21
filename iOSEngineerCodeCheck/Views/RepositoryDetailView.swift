//
//  RepositoryDetailView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepositoryDetailView: View {

    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            TitleSection(repository: repository)
            Divider()
            AboutSection(repository: repository)
            languageSection(language: repository.language)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: Language Section
    
    @ViewBuilder
    private func languageSection(language: String?) -> some View {
        if let language,
           !language.isEmpty {
            Divider()
            LanguageSection(language: language)
        }
    }
}

struct RepositoryDetailView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            RepositoryDetailView(repository: Repository.sampleData[1])
            RepositoryDetailView(repository: Repository.sampleData[0])
        }
    }
}
