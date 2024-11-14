//
//  RepoCell.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/14.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Shimmer

struct RepoCell: View {

    let repo: Repo
    
    private var languageColor: Color {
        guard let languageName = repo.language else {
            return .clear
        }
        return LanguageRepository.shared.fetch(name: languageName)?.color ?? .clear
    }

    var body: some View {
        VStack(alignment: .leading) {
            userLabel()
            repoNameLabel()
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
            WebImage(url: URL(string: repo.owner.avatarImagePath)) { image in
                image
            } placeholder: {
                Image(systemName: "person.fill")
                    .resizable()
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
            Text(repo.owner.name)
                .lineLimit(1)
        }
    }

    @ViewBuilder
    private func repoNameLabel() -> some View {
        Text(repo.name)
            .lineLimit(1)
            .font(.title3)
            .bold()
            .padding(.vertical, 2)
    }

    @ViewBuilder
    private func descriptionLabel() -> some View {
        if let description = repo.description,
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
            Text(String.compactName(repo.starsCount))
        }
        .foregroundStyle(.secondary)
    }

    @ViewBuilder
    private func languageLabel() -> some View {
        if let language = repo.language,
           !language.isEmpty {
            HStack(spacing: 4) {
                Circle()
                    .frame(width: 14, height: 14)
                    .foregroundStyle(languageColor)
                Text(language)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Previews

#Preview("通常", traits: .sizeThatFitsLayout) {
    RepoCell(repo: Repo.sampleData[0])
        .padding()
}

#Preview("長い語句を含む場合", traits: .sizeThatFitsLayout) {
    RepoCell(repo: Repo.sampleDataWithLongWord)
        .padding()
}

#Preview("空の情報がある場合", traits: .sizeThatFitsLayout) {
    RepoCell(repo: Repo.sampleDataWithoutSomeInfo)
        .padding()
}
