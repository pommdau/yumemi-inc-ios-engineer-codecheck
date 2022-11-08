//
//  GitHubAPIServiceProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GitHubAPIServiceProtocol {
    func request<Request>(with request: Request) async throws ->
    Request.Response where Request: GitHubAPIRequestProtocol
}

extension GitHubAPIServiceProtocol {
    func request<Request>(with request: Request) async throws ->
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
            let errorString = String(data: data, encoding: .utf8) ?? ""
            print(errorString)
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
        let responseString = String(data: data, encoding: .utf8) ?? ""
        print(responseString)
        #endif
        do {
            let response = try JSONDecoder().decode(Request.Response.self, from: data)
            return response
        } catch {
            throw GitHubAPIServiceError.responseParseError(error)
        }
    }
}
