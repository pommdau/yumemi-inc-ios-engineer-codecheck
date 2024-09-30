//
//  LanguageView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/21.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct LanguageView: View {

    let language: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Language")
                .font(.title2)
                .bold()
            HStack(spacing: 8) {
                Circle()
                    .frame(width: 14, height: 14)
                    .foregroundColor(GitHubLanguageColorManager.shared.getColor(withLanguageName: language))
                Text(language)
            }
        }
    }
}

// MARK: - Previews

#Preview("Swift", traits: .sizeThatFitsLayout) {
    LanguageView(language: "Swift")
        .padding()
}

#Preview("JavaScript", traits: .sizeThatFitsLayout) {
    LanguageView(language: "JavaScript")
        .padding()
}
