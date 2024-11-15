//
//  GitHubAPIRequestProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GitHubAPIRequestProtocol {
    associatedtype Response: Decodable

    var baseURL: URL { get }
    var path: String { get }  // baesURLからの相対パス
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var header: [String: String] { get }
    var body: Data? { get }  // HTTP bodyに設定するパラメータ
}

extension GitHubAPIRequestProtocol {

    var baseURL: URL {
        guard let baseURL = URL(string: "https://api.github.com") else {
            assertionFailure("リポジトリ検索用のURLの作成に失敗しました")
            return URL(fileURLWithPath: "")
        }
        return baseURL
    }

    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var urlRequest = URLRequest(url: url)

        // クエリ・ヘッダの設定
        components?.queryItems = queryItems  // クエリの追加
        for (key, value) in header {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        // ボディの設定
        if let body {
            urlRequest.httpBody = body
        }

        urlRequest.url = components?.url  // URLComponents型からURL型を取得。これにより適切なエンコードを施したクエリ文字列が付与される
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }

}
