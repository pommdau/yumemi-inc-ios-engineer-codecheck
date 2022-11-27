//
//  SearchRepositoriesProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/27.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchRepositoriesProtocol {
    static var shared: Self { get }
    func search(keyword: String) async throws -> [Repository]
}
