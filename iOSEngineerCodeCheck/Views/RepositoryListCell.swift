//
//  RepositoryListCell.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/14.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct RepositoryListCell: View {

    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            userLabel(userName: repository.owner.name,
                      avatarImagePath: repository.owner.avatarImagePath)
            Text(repository.name)
                .font(.title2)
                .bold()
                .padding(.vertical, 2)
            descriptionLabel(repository: repository)
            HStack(spacing: 18) {
                starsLabel(starsCount: repository.starsCount)
                languageLabel(language: repository.language)
            }
        }
    }

    // MARK: - ViewBuilder

    @ViewBuilder
    private func userLabel(userName: String, avatarImagePath: String) -> some View {
        HStack {
            WebImage(url: URL(string: avatarImagePath))
                .resizable()
                .placeholder(Image(systemName: "person.fill"))
                .frame(width: 24, height: 24)
                .cornerRadius(12)
            Text(userName)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
    }
    
    @ViewBuilder
    private func descriptionLabel(repository: Repository) -> some View {
        if let description = repository.description,
           !description.isEmpty {
            Text(description)
        }
    }

    @ViewBuilder
    private func starsLabel(starsCount: Int) -> some View {
        HStack(spacing: 2) {
            Image(systemName: "star")
            Text("\(starsCount)")
        }
        .foregroundColor(.secondary)
    }

    @ViewBuilder
    private func languageLabel(language: String?) -> some View {
        if let language,
           !language.isEmpty {
            HStack(spacing: 4) {
                Circle()
                    .frame(width: 14, height: 14)
                    .foregroundColor(GitHubLanguageColor.shared.getColor(withName: language))
                Text(language)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct RepositoryListCell_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            RepositoryListCell(repository: Repository.sampleData[0])
                .previewLayout(.fixed(width: 200, height: 400))
                .padding()
            
            RepositoryListCell(repository: Repository.sampleData[1])
                .previewLayout(.fixed(width: 200, height: 400))
                .padding()
        }
    }
}
