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
                if let serviceError = error as? GitHubAPIServiceError {
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

struct FailedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FailedView(error:
                        GitHubAPIServiceError.connectionError(
                            MessageError(description: "(Debug) connectionError")
                        )
            )
            .previewDisplayName(".connectionError")

            FailedView(error:
                        GitHubAPIServiceError.responseParseError(
                            MessageError(description: "(Debug) responseParseError.")
                        )
            )
            .previewDisplayName(".responseParseError")

            FailedView(error:
                        GitHubAPIServiceError.apiError(
                            GitHubAPIError.sampleData[0]
                        )
            )
            .previewDisplayName(".apiError")

            FailedView(error: MessageError(description: "(Debug) other error"))
                .previewDisplayName("other error")
        }
    }
}
