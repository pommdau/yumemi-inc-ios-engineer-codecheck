//
//  RepoListSkelton.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2024/09/30.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct RepoListSkelton: View {
    
    let numberOfCells: Int
        
    var body: some View {
        List {
            ForEach(0..<numberOfCells, id: \.self) { _ in
                RepoCellSkelton()
            }
        }
    }
    
    init(numberOfCells: Int = 6) {
        self.numberOfCells = numberOfCells
    }
}

#Preview {
    RepoListSkelton()
}
