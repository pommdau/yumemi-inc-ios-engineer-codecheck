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
                Text("リポジトリの検索中にエラーが発生しました")
                    .padding(.bottom, 8)
                if let serviceError = error as? GitHubAPIServiceError {
                    switch serviceError {
                    case .connectionError(let error):
                        Text(error.localizedDescription)
                    case .responseParseError(let error):
                        Text(error.localizedDescription)
                    case .apiError(let gitHubAPIError):
                        Text(gitHubAPIError.message)
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
        FailedView(error: MessageError(description: "debug error"))
    }
}
