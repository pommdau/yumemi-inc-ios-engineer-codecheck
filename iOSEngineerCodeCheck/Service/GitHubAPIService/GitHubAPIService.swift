//
//  GitHubAPIService.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/27.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

final actor GitHubAPIService: GitHubAPIServiceProtocol {

    static let shared: GitHubAPIService = .init()

    func searchRepositories(keyword: String) async throws -> [Repository] {
        let response = try await request(with: GitHubAPIRequest.SearchRepositories(keyword: keyword))
        let repositories = response.items
        
        /* TODO: API制限に引っかかってしまうため、別の方法で代替すること
        // リポジトリの詳細情報を取得して情報を追加する
        let details = try await FetchRepositoryDetail.shared.fetchRepositoryDetails(withRepositories: repositories)
        for (index, _) in details.enumerated() {
            repositories[index].update(withRepositoryDetail: details[index])
        }
         */
        
        return repositories
    }
}

extension GitHubAPIService {
    private func request<Request>(with request: Request) async throws ->
    Request.Response where Request: GitHubAPIRequestProtocol {

        let (data, response): (Data, URLResponse)
        do {
            let urlRequest = request.buildURLRequest()
            (data, response) = try await URLSession.shared.data(for: urlRequest)
        } catch {
            throw GitHubAPIServiceError.connectionError(error)
        }

        guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
              (200..<300).contains(statusCode) else {
            // エラーレスポンス
            #if DEBUG
            //            let errorString = String(data: data, encoding: .utf8) ?? ""
            //            print(errorString)
            #endif

            let gitHubAPIError: GitHubAPIError
            do {
                gitHubAPIError = try JSONDecoder().decode(GitHubAPIError.self, from: data)
            } catch {
                throw GitHubAPIServiceError.responseParseError(error)
            }
            throw GitHubAPIServiceError.apiError(gitHubAPIError)
        }

        // 成功レスポンス
        #if DEBUG
//        let responseString = String(data: data, encoding: .utf8) ?? ""
//        print(responseString)
        #endif
        do {
            let response = try JSONDecoder().decode(Request.Response.self, from: data)
            return response
        } catch {
            throw GitHubAPIServiceError.responseParseError(error)
        }
    }
}
