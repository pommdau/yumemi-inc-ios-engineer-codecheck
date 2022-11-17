//
//  GitHubAPIRequest+GetRepositoryDetail.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//
/*  Discussion:
> https://docs.github.com/ja/rest/overview/resources-in-the-rest-api#rate-limiting
> For unauthenticated requests, the rate limit allows for up to 60 requests per hour. Unauthenticated requests are associated with the originating IP address, and not the person making requests.
 レート制限があるので、リポジトリごとに情報を取得していると簡単に上限に達してしまう。
 認証すれば話は別だが、現状では別の方法があるか考えたい。
*/

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
