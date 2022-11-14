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
            userLabel()

            Text(repository.name)
                .font(.title2)
                .bold()
                .padding(.vertical, 2)

            HStack(spacing: 18) {
                starsLabel()
                if (repository.language?.isEmpty) != nil {
                    languageLabel()
                }
            }
        }
    }

    // MARK: - ViewBuilder

    @ViewBuilder
    private func userLabel() -> some View {
        HStack {
            Image(systemName: "person.fill")
                .font(.system(size: 24))
            Text(repository.owner.name)
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private func starsLabel() -> some View {
        HStack(spacing: 2) {
            Image(systemName: "star")
            Text("\(repository.starsCount)")
        }
        .foregroundColor(.secondary)
    }

    @ViewBuilder
    private func languageLabel() -> some View {
        HStack(spacing: 4) {
            Circle()
                .frame(width: 12, height: 12)
                .foregroundColor(.red)
            Text(repository.language ?? "")
                .foregroundColor(.secondary)
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
