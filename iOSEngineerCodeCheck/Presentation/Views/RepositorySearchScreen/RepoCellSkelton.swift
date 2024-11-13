//
//  RepoCellSkelton.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2024/09/30.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepoCellSkelton: View {
    var body: some View {
        RepoCell(repo: Repo.sampleDataForReposCellSkelton)
            .redacted(reason: .placeholder)
            .shimmering()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RepoCellSkelton()
        .padding()
}
