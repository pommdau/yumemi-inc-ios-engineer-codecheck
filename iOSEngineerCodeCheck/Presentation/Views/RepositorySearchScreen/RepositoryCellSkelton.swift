//
//  RepositoryCellSkelton.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2024/09/30.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepositoryCellSkelton: View {
    var body: some View {
        RepositoryCell(repository: Repository.sampleDataForRepositoryCellSkelton)
            .redacted(reason: .placeholder)
            .shimmering()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RepositoryCellSkelton()
        .padding()
}
