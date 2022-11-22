//
//  LanguageSection.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/21.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct LanguageSection: View {
    
    let language: String
    
    @ViewBuilder
    var body: some View {
        VStack(alignment: .leading) {
            Text("Language")
                .font(.title2)
                .bold()
            HStack(spacing: 8) {
                Circle()
                    .frame(width: 14, height: 14)
                    .foregroundColor(GitHubLanguageColor.shared.getColor(withName: language))
                Text(language)
            }
        }
    }
}

struct LanguageSection_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSection(language: "Swift")
            .previewLayout(.fixed(width: 400, height: 200))
    }
    
}
