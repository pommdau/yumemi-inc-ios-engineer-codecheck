//
//  Language.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2024/11/13.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct Language {
    private var uuid: String
    let name: String
    let color: Color

    /// Initializer
    /// - Parameters:
    ///   - name: Language name
    ///   - hex: e.g.  "#00cafe"
    init(name: String, hex: String, uuid: String = UUID().uuidString) {
        self.uuid = uuid
        self.name = name
        self.color = Color(hex: hex.replacingOccurrences(of: "#", with: ""))
    }
}

extension Language: Identifiable {
    var id: String {
        uuid
    }
}
