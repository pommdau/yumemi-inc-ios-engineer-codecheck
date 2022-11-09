//
//  User.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct User: Identifiable, Codable {
    var id: Int
    var name: String
    var avatarImagePath: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case avatarImagePath = "avatar_url"
    }
}
