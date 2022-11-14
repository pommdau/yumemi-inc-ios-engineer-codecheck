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
            HStack {
                Image(systemName: "person.fill")
                    .font(.system(size: 28))
                Text(repository.fullName)
                    .foregroundColor(.secondary)
            }

            Text(repository.name)
                .font(.title2)
                .bold()
                .padding(.vertical, 2)

            Text("<description>")

            Grid {
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
                        .foregroundColor(.red)
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
