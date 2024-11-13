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
        VStack(alignment: .leading, spacing: 8) {
            userLabel()
            repositoryLabel()
        }
    }
    
    @ViewBuilder
    private func userLabel() -> some View {
        Button {
            guard let url = repository.owner.htmlURL else {
                return
            }
            UIApplication.shared.open(url)
        } label: {
            HStack {
                // Userアイコン
                WebImage(url: repository.owner.avatarImageURL) { image in
                    image
                } placeholder: {
                    Image(systemName: "person.fill")
                        .accessibilityLabel(Text("User Image"))
                }
                .resizable()
                .accessibilityLabel(Text("User Image"))
                .frame(maxWidth: 40, maxHeight: 40)
                .cornerRadius(20)
                .background {
                    Circle()
                        .stroke(lineWidth: 1)
                        .foregroundColor(.secondary)
                }
                // User名
                Text(repository.owner.name)
                    .lineLimit(1)
            }
        }
        .foregroundStyle(.secondary)
    }

    @ViewBuilder
    private func repositoryLabel() -> some View {
        Button {
            guard let url = repository.htmlURL else {
                return
            }
            UIApplication.shared.open(url)
        } label: {
            Text(repository.name)
                .lineLimit(1)
                .font(.title)
                .bold()
        }
        .foregroundStyle(.primary)
    }
}

// MARK: - Previews

#Preview("通常", traits: .sizeThatFitsLayout) {
    TitleView(repository: Repository.sampleData[2])
        .padding()
}

#Preview("長い語句を含む場合", traits: .sizeThatFitsLayout) {
    TitleView(repository: Repository.sampleDataWithLongWord)
        .padding()
}
