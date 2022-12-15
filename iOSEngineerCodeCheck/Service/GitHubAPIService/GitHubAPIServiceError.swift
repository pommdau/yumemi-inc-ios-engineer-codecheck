//
//  GitHubAPIServiceError.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

enum GitHubAPIServiceError: Error {
    // 通信に失敗
    case connectionError(Error)

    // レスポンスの解釈に失敗
    case responseParseError(Error)

    // APIからエラーレスポンスを受け取った
    case apiError(GitHubAPIError)
    
    var message: String {
        switch self {
        case .connectionError:
            return "通信エラー"
        case .responseParseError:
            return "データの取得に失敗"
        case .apiError(let gitHubAPIError):
            return gitHubAPIError.message
        }
    }
}
