//
//  RepositoryDetailView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct RepositoryDetailView: View {

    let repository: Repository

    var body: some View {

        VStack(alignment: .leading) {
            titleSection(repository: repository)
            Divider()
            aboutSection(repository: repository)
            Divider()
            languageSection(language: repository.language)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
        
    @ViewBuilder
    private func titleSection(repository: Repository) -> some View {
        HStack(spacing: 8) {
            WebImage(url: URL(string: repository.owner.avatarImagePath))
                .resizable()
                .placeholder(Image(systemName: "person.fill"))
                .frame(maxWidth: 40, maxHeight: 40)
                .cornerRadius(20)
            Button {
                guard let url = URL(string: repository.owner.htmlPath) else {
                    return
                }
                UIApplication.shared.open(url)
            } label: {
                Text(repository.owner.name)
                    .lineLimit(1)
                    .font(.title2)
            }
            Text("/")
            Button {
                guard let url = URL(string: repository.htmlPath) else {
                    return
                }
                UIApplication.shared.open(url)
            } label: {
                Text(repository.name)
                    .lineLimit(1)
                    .font(.title2)
                    .bold()
            }
        }
    }
    
    @ViewBuilder
    private func aboutSection(repository: Repository) -> some View {
        VStack(alignment: .leading) {
            Text("About")
                .font(.title2)
                .bold()
                .padding(.vertical)
            if let description = repository.description,
               !description.isEmpty {
                Text(repository.description ?? "(description)")
                    .padding(.bottom, 8)
            }
            Grid(verticalSpacing: 8) {
                GridRow {
                    Image(systemName: "star")
                        .foregroundColor(.secondary)
                        .gridColumnAlignment(.center)
                    Text("\(IntegerFormatStyle<Int>().notation(.compactName).format(repository.starsCount))")
                        .bold()
                        .gridColumnAlignment(.trailing)
                    Text("stars")
                        .foregroundColor(.secondary)
                        .gridColumnAlignment(.leading)
                }
                /*
                GridRow {
                    Image(systemName: "eye")
                        .foregroundColor(.secondary)
                    Text("\(repository.watchersCount)")
                        .bold()
                    Text("watching")
                        .foregroundColor(.secondary)
                }
                 */
                GridRow {
                    Image(systemName: "arrow.triangle.branch")
                        .foregroundColor(.secondary)
                    Text("\(IntegerFormatStyle<Int>().notation(.compactName).format(repository.forksCount))")
                        .bold()
                    Text("forks")
                        .foregroundColor(.secondary)
                }
                GridRow {
                    Image(systemName: "circle.circle")
                        .foregroundColor(.secondary)
                    Text("\(IntegerFormatStyle<Int>().notation(.compactName).format(repository.openIssuesCount))")
                        .bold()
                    Text("issues")
                        .foregroundColor(.secondary)
                }
                
                if let website = repository.website {
                    GridRow {
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                        Button {
                            guard let url = URL(string: website) else {
                                return
                            }
                            UIApplication.shared.open(url)
                        } label: {
                            Text("\(website)")
                                .bold()
                        }
                        .gridCellColumns(3)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func languageSection(language: String?) -> some View {
        if let language, !language.isEmpty {
            VStack(alignment: .leading) {
                Text("Language")
                    .font(.title2)
                    .bold()
                HStack(spacing: 8) {
                    Circle()
                        .frame(width: 14, height: 14)
                        .foregroundColor(GitHubLanguageColor.shared.getColor(withName: language))
                    Text(repository.language ?? "")
                }
            }
        }
    }
}

struct RepositoryDetailView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            RepositoryDetailView(repository: Repository.sampleData[0])
            RepositoryDetailView(repository: Repository.sampleData[1])
        }
    }
}
