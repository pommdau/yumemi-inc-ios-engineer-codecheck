//
//  TitleSection.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/21.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct TitleView: View {

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
                .accessibilityLabel(Text("User Image"))
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

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TitleView(repository: Repository.sampleData[0])
                .previewDisplayName("通常")
            TitleView(repository: Repository.sampleDataWithLongWord)
                .previewDisplayName("長い語句を含む場合")
        }
        .previewLayout(.fixed(width: 600, height: 200))
    }
}
