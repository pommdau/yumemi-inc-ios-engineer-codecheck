//
//  GitHubAPIClient+request.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/30.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

extension GitHubAPIClient {

    func request<Request>(with request: Request) async throws ->
    Request.Response where Request: GitHubAPIRequestProtocol {
        
        let (data, response): (Data, URLResponse)
        do {
            let urlRequest = request.buildURLRequest()
            (data, response) = try await urlSession.data(for: urlRequest)
        } catch {
            throw GitHubAPIClientError.connectionError(error)
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
                throw GitHubAPIClientError.responseParseError(error)
            }
            throw GitHubAPIClientError.apiError(gitHubAPIError)
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
            throw GitHubAPIClientError.responseParseError(error)
        }
    }
}
