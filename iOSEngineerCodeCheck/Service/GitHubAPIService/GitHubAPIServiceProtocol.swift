//
//  GitHubAPIServiceProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GitHubAPIServiceProtocol {
    
    static var shared: Self { get }
        
    func searchRepositories(keyword: String) async throws -> [Repository]
}
