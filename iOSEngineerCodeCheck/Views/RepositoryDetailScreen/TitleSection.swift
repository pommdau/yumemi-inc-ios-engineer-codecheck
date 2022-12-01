//
//  TitleSection.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/21.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct TitleSection: View {

    let repository: Repository

    var body: some View {
        HStack(spacing: 8) {
            userIcon()
            userLink()
            Text("/")
            repositoryLink()
        }
    }

    @ViewBuilder
    private func userIcon() -> some View {
        Button {
            guard let url = repository.owner.htmlURL else {
                return
            }
            UIApplication.shared.open(url)
        } label: {
            WebImage(url: repository.owner.avatarImageURL)
                .resizable()
                .placeholder(Image(systemName: "person.fill"))
                .frame(maxWidth: 40, maxHeight: 40)
                .cornerRadius(20)
        }
    }

    @ViewBuilder
    private func userLink() -> some View {
        Button {
            guard let url = repository.owner.htmlURL else {
                return
            }
            UIApplication.shared.open(url)
        } label: {
            Text(repository.owner.name)
                .lineLimit(1)
                .font(.title2)
        }
    }

    @ViewBuilder
    private func repositoryLink() -> some View {
        Button {
            guard let url = repository.htmlURL else {
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

struct TitleSection_Previews: PreviewProvider {
    static var previews: some View {
        TitleSection(repository: Repository.sampleData[0])
            .previewLayout(.fixed(width: 600, height: 200))
    }
}
