//
//  SearchSuggestionRepositoryProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2024/11/13.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchSuggestionRepositoryProtocol {
    
    // MARK: - Property
    
    var maxHistoryCount: Int { get }
    var recommendedSuggestions: [String] { get }
    var historySuggestions: [String] { get set }
        
    // MARK: - CRUD
    func addHistory(_ keyword: String)
    func removeAllHistories()
}
