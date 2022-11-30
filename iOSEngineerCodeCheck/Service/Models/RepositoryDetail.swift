//
//  RepositoryDetail.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

// e.g. https://api.github.com/repos/apple/swift
struct RepositoryDetail: Decodable {
    let subscribersCount: Int

    private enum CodingKeys: String, CodingKey {
        case subscribersCount = "subscribers_count"
    }
}
