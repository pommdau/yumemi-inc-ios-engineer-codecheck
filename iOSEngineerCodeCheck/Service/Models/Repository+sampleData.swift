//
//  Repository+sampleData.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

extension Repository {

    static let sampleData: [Repository] = [
        .init(id: 44838949,
              name: "swiftapple_apple_apple_apple_apple_apple_apple_apple_apple_apple_apple_apple_apple_",
              fullName: "apple/swift",
              owner:
                User(id: 10639145,
                     name: "appleapple_apple_apple_apple_apple_apple_apple_apple_apple_",
                     avatarImagePath: "https://avatars.githubusercontent.com/u/10639145?v=4",
                     htmlPath: "https://github.com/apple"),
              starsCount: 61080,
              watchersCount: 2100,
              forksCount: 9815,
              openIssuesCount: 6175,
              language: "C++",
              htmlPath: "https://github.com/apple/swift",
              website: "https://www.swift.org/",
              description: "The Swift Programming Language",
              subscribersCount: 2508),
        .init(id: 20682114,
              name: "SwiftLanguageWeather_longlonglonglonglonglonglonglong",
              fullName: "JakeLin/SwiftLanguageWeather",
              owner:
                User(id: 573856,
                     name: "JakeLin_longlonglonglonglonglonglonglong",
                     avatarImagePath: "https://avatars.githubusercontent.com/u/573856?v=4",
                     htmlPath: "https://github.com/apple"),
              starsCount: 5202,
              watchersCount: 300,
              forksCount: 1220,
              openIssuesCount: 9,
              language: nil,
              htmlPath: "https://github.com/JakeLin/SwiftLanguageWeather",
              website: nil,
              description: nil)
    ]

}
