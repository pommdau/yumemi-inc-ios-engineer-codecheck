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
                Text(R.string.localizable.repositorySearchScreenFailedViewTitle())
                    .padding(.bottom, 8)
                if let serviceError = error as? GitHubAPIClientError {
                    Text(serviceError.message)
                } else {
                    Text(error.localizedDescription)
                }
            }
            .foregroundStyle(.secondary)
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
