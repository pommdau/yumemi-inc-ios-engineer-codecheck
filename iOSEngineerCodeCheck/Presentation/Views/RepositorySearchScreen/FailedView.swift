//
//  SearchFailedView.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/12/01.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct FailedView: View {

    let error: Error

    var body: some View {
        VStack {
            Group {
                Text("リポジトリの検索に失敗しました")
                    .padding(.bottom, 8)
                if let serviceError = error as? GitHubAPIClientError {
                    switch serviceError {
                    case .connectionError:
                        Text(serviceError.message)
                    case .responseParseError:
                        Text(serviceError.message)
                    case .apiError:
                        Text(serviceError.message)
                    }
                } else {
                    Text(error.localizedDescription)
                }
            }
            .foregroundColor(.secondary)
        }
    }
}

// MARK: - Previews

#Preview(".connectionError", traits: .sizeThatFitsLayout) {
    let error = GitHubAPIClientError.connectionError(
        MessageError(description: "(Debug) connectionError")
    )
    return FailedView(error: error)
        .padding()
}

#Preview(".responseParseError", traits: .sizeThatFitsLayout) {
    let error = GitHubAPIClientError.responseParseError(
        MessageError(description: "(Debug) responseParseError.")
    )
    return FailedView(error: error)
        .padding()
}

#Preview(".apiError", traits: .sizeThatFitsLayout) {
    let error = GitHubAPIClientError.apiError(
        GitHubAPIError.sampleData[0]
    )
    return FailedView(error: error)
        .padding()
}

#Preview("other error", traits: .sizeThatFitsLayout) {
    let error = MessageError(description: "(Debug) other error")
    return FailedView(error: error)
        .padding()
}
