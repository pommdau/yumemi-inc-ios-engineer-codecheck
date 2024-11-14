//
//  SearchReadyView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/12/01.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct ReadyView: View {
    var body: some View {
        VStack {
            Text(R.string.localizable.repositorySearchScreenReadyViewTitle)
                .font(.title)
                .bold()
                .padding()
            Text(R.string.localizable.repositorySearchScreenReadyViewInformativeText)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Previews

#Preview {
    ReadyView()
}
