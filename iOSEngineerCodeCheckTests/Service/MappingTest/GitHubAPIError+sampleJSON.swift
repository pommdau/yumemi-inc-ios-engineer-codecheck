//
//  GitHubAPIError+sampleJSON.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/11/25.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck

extension GitHubAPIError {
    static var sampleJSON: String {
        """
        {
          "message": "Validation Failed",
          "errors": [
            {
              "resource": "Search",
              "field": "q",
              "code": "missing"
            }
          ],
          "documentation_url": "https://developer.github.com/v3/search"
        }
        """
    }
}
