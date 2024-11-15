//
//  LanguageView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/21.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct LanguageView: View {

    let languageName: String
    
    private var languageColor: Color {
        LanguageStore.shared.fetch(name: languageName)?.color ?? .clear
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Language")
                .font(.title2)
                .bold()
            HStack(spacing: 8) {
                Circle()
                    .frame(width: 14, height: 14)
                    .foregroundStyle(languageColor)
                Text(languageName)
            }
        }
    }
}

// MARK: - Previews

#Preview("Swift", traits: .sizeThatFitsLayout) {
    LanguageView(languageName: "Swift")
        .padding()
}

#Preview("JavaScript", traits: .sizeThatFitsLayout) {
    LanguageView(languageName: "JavaScript")
        .padding()
}
