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
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                    Text(repository.fullName)
                }
                .padding(.bottom, 20)

                Text("About")
                    .font(.title2)

                Text("<description>")

                Grid {
                    GridRow {
                        Image(systemName: "star")
                            .gridColumnAlignment(.center)
                        Text("\(repository.starsCount)")
                            .gridColumnAlignment(.trailing)
                        Text("stars")
                            .gridColumnAlignment(.leading)
                    }
                    GridRow {
                        Image(systemName: "eye")
                        Text("\(repository.watchersCount)")
                        Text("watching")
                    }
                    GridRow {
                        Image(systemName: "arrow.triangle.branch")
                        Text("\(repository.forksCount)")
                        Text("forks")
                    }
                }
                .padding(.vertical)

                Divider()

                Text("Languages")
                    .font(.title2)
                Text(repository.language ?? "")

                Spacer()
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
