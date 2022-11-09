//
//  GitHubAPIRequest+SearchRepositories.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

extension GitHubAPIRequest {

    public struct SearchRepositories: GitHubAPIRequestProtocol {
        public let keyword: String
        public typealias Response = SearchResponse<Repository>

        // MARK: - Properties

        public var method: HTTPMethod {
            .get
        }

        public var path: String {
            "/search/repositories"
        }

        public var queryItems: [URLQueryItem] {
            [URLQueryItem(name: "q", value: keyword)]
        }

        public var header: [String: String] {
            .init()
        }

        public var body: Data? {
            nil
        }
    }

}
