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
            userLabel()
            repositoryNameLabel()
            descriptionLabel()
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
            WebImage(url: URL(string: repository.owner.avatarImagePath)) { image in
                image
            } placeholder: {
                Image(systemName: "person.fill")
            }
            .resizable()
            .frame(width: 24, height: 24)
            .cornerRadius(12)
            .accessibilityLabel(Text("User Image"))
            .background {
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.secondary.opacity(0.5))
            }
            Text(repository.owner.name)
                .lineLimit(1)
        }
    }

    @ViewBuilder
    private func repositoryNameLabel() -> some View {
        Text(repository.name)
            .lineLimit(1)
            .font(.title3)
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
                .accessibilityLabel(Text("Star Image"))
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

// MARK: - Previews

#Preview("通常", traits: .sizeThatFitsLayout) {
    RepositoryCell(repository: Repository.sampleData[0])
        .padding()
}

#Preview("長い語句を含む場合", traits: .sizeThatFitsLayout) {
    RepositoryCell(repository: Repository.sampleDataWithLongWord)
        .padding()
}

#Preview("空の情報がある場合", traits: .sizeThatFitsLayout) {
    RepositoryCell(repository: Repository.sampleDataWithoutSomeInfo)
        .padding()
}
