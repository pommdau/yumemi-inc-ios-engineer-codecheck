//
//  GitHubAPIClientError.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

enum GitHubAPIClientError: Error {
    // APIのリクエストの作成に失敗
    case invalidRequest
    
    // 通信に失敗
    case connectionError(Error)

    // レスポンスの解釈に失敗
    case responseParseError(Error)

    // APIからエラーレスポンスを受け取った
    case apiError(GitHubAPIError)
    
    var message: String {
        switch self {
        case .invalidRequest:
            return R.string.localizable.gitHubAPIGitHubAPIClientErrorMessageInvalidRequest()
        case .connectionError:
            return R.string.localizable.gitHubAPIGitHubAPIClientErrorMessageConnectionError()
        case .responseParseError:
            return R.string.localizable.gitHubAPIGitHubAPIClientErrorMessageResponseParseError()
        case .apiError(let gitHubAPIError):
            return gitHubAPIError.message
        }
    }
}
