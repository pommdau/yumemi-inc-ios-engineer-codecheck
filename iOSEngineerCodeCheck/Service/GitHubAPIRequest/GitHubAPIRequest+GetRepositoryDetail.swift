//
//  GitHubAPIRequest+GetRepositoryDetail.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

extension GitHubAPIRequest {

    public struct GetRepositoryDetail: GitHubAPIRequestProtocol {
        
        public typealias Response = RepositoryDetail
        public let userName: String
        public let repositoryName: String

        public var method: HTTPMethod {
            .get
        }

        public var path: String {
            "/repos/\(userName)/\(repositoryName)"
        }

        public var queryItems: [URLQueryItem] {
            []
        }

        public var header: [String: String] {
            ["Accept": "application/vnd.github.v3+json"]
        }

        public var body: Data? {
            nil
        }
    }

}
