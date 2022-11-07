//
//  SearchResponse.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

// TODO: itemsの型のジェネリクス化
struct SearchResponse: Decodable {
    let totalCount: Int
    let items: [Repository]

    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
