//
//  GitHubAPIError.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

// ref: https://docs.github.com/en/rest/overview/resources-in-the-rest-api#client-errors
public struct GitHubAPIError: Decodable, Error {
    public struct Error: Decodable {
        public var resource: String
        public var field: String
        public var code: String
    }

    public var message: String  // レスポンスのJSONに必ず含まれる
    public var errors: [Error?]?
}
