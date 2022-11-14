//
//  RepositoryListCell.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/14.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepositoryListCell: View {

    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.fill")
                    .font(.system(size: 24))
                Text(repository.owner.name)
                    .foregroundColor(.secondary)
            }

            Text(repository.name)
                .font(.title2)
                .bold()
                .padding(.vertical, 2)

            Text("<description>")

            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "star")
                    Text("\(repository.starsCount)")
                }
                .foregroundColor(.secondary)

                HStack(spacing: 4) {
                    Circle()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.red)
                    Text(repository.language ?? "")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct RepositoryListCell_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListCell(repository: Repository.sampleData[0])
            .previewLayout(.fixed(width: 400, height: 400))
            .padding()

        RepositoryListCell(repository: Repository.sampleData[1])
            .previewLayout(.fixed(width: 400, height: 400))
            .padding()
    }
}
