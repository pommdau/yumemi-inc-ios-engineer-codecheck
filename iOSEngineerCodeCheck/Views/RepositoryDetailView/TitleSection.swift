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
}

struct TitleSection_Previews: PreviewProvider {
    static var previews: some View {
        TitleSection(repository: Repository.sampleData[0])
    }
}
