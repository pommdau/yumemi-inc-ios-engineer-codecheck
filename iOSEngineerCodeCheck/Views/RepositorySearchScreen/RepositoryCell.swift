//
//  RepositoryCell.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/14.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct RepositoryCell: View {

    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            repositoryNameLabel()
            descriptionLabel()
            userLabel()
            HStack(spacing: 18) {
                starsLabel()
                languageLabel()
            }
            .padding(.top, 2)
        }
    }

    // MARK: - ViewBuilder

    @ViewBuilder
    private func userLabel() -> some View {
        HStack {
            WebImage(url: URL(string: repository.owner.avatarImagePath))
                .resizable()
                .placeholder(Image(systemName: "person.fill"))
                .frame(width: 24, height: 24)
                .cornerRadius(12)
            Text(repository.owner.name)
                .lineLimit(1)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.secondary.opacity(0.2))
                .frame(height: 40)
        )
    }

    @ViewBuilder
    private func repositoryNameLabel() -> some View {
        Text(repository.name)
            .lineLimit(1)
            .font(.title2)
            .bold()
            .padding(.vertical, 2)
    }

    @ViewBuilder
    private func descriptionLabel() -> some View {
        if let description = repository.description,
           !description.isEmpty {
            Text(description)
                .lineLimit(3)
        }
    }

    @ViewBuilder
    private func starsLabel() -> some View {
        HStack(spacing: 2) {
            Image(systemName: "star")
            Text("\(IntegerFormatStyle<Int>().notation(.compactName).format(repository.starsCount))")
        }
        .foregroundColor(.secondary)
    }

    @ViewBuilder
    private func languageLabel() -> some View {
        if let language = repository.language,
           !language.isEmpty {
            HStack(spacing: 4) {
                Circle()
                    .frame(width: 14, height: 14)
                    .foregroundColor(GitHubLanguageColorManager.shared.getColor(withLanguageName: language))
                Text(language)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct RepositoryCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RepositoryCell(repository: Repository.sampleData[0])
                .previewDisplayName("通常")
            
            RepositoryCell(repository: Repository.sampleDataWithLongWord)
                .previewDisplayName("長い語句を含む場合")
            
            RepositoryCell(repository: Repository.sampleDataWithoutSomeInfo)
                .previewDisplayName("空の情報がある場合")
        }
        .padding()
        .previewLayout(.fixed(width: 400, height: 400))
    }
}
