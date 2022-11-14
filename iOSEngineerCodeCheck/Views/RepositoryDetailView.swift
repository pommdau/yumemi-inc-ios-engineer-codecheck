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
            HStack {
                WebImage(url: URL(string: repository.owner.avatarImagePath))
                    .resizable()
                    .placeholder(Image(systemName: "person.fill"))
                    .frame(maxWidth: 60, maxHeight: 60)
                Text(repository.owner.name)
                    .font(.title2)
                    .foregroundColor(.secondary)
            }

            Text(repository.name)
                .font(.title)
                .bold()
                .padding(.vertical, 2)

            Grid(verticalSpacing: 8) {
                GridRow {
                    Image(systemName: "star")
                        .foregroundColor(.secondary)
                        .gridColumnAlignment(.center)
                    Text("\(repository.starsCount)")
                        .bold()
                        .gridColumnAlignment(.trailing)
                    Text("stars")
                        .foregroundColor(.secondary)
                        .gridColumnAlignment(.leading)
                }
                GridRow {
                    Image(systemName: "eye")
                        .foregroundColor(.secondary)
                    Text("\(repository.watchersCount)")
                        .bold()
                    Text("watching")
                        .foregroundColor(.secondary)
                }
                GridRow {
                    Image(systemName: "arrow.triangle.branch")
                        .foregroundColor(.secondary)
                    Text("\(repository.forksCount)")
                        .bold()
                    Text("forks")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical)

            Divider()

            VStack(alignment: .leading) {
                Text("Languages")
                    .font(.title2)
                HStack(spacing: 8) {
                    Circle()
                        .frame(width: 14, height: 14)
                        .foregroundColor(GitHubLanguageColor.shared.getColor(withName: repository.language))
                    Text(repository.language ?? "")
                }
            }

            Spacer()
        }
        .padding()
    }
}

struct RepositoryDetailView_Previews: PreviewProvider {

    @State static var repository = Repository.sampleData[0]

    static var previews: some View {
        RepositoryDetailView(repository: repository)
    }
}
