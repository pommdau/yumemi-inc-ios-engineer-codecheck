//
//  StubURLSession.swift
//  iOSEngineerCodeCheckTests
//
//  Created by HIROKI IKEUCHI on 2022/12/01.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

/// GitHubAPIClientのテストで使用するURLSessionのStub
class StubURLSession: URLSessionProtocol {
    private let stubbedData: Data?
    private let stubbedResponse: URLResponse?
    private let stubbedError: Error?
    
    init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.stubbedData = data
        self.stubbedResponse = response
        self.stubbedError = error
    }
        
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let stubbedError {
            throw stubbedError
        }
        
        guard let stubbedData,
           let stubbedResponse else {
               fatalError("(date, response)かerrorのどちらかのパラメータを設定してください")
        }
        
        return (stubbedData, stubbedResponse)
    }
}
