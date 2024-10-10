//
//  SearchSuggestionManager.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2024/10/10.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct SearchSuggestionManager {
    
    private let maxHistoryCount: Int = 3 // 履歴の最大記憶数
    
    let recommendedSuggestions: [String] = ["SwiftUI", "Swift", "Python", "Apple", "Qiita"]
    
    // 複数存在するようになった場合はこのIdentifiedなキーにすること
    @AppStorage("searchHistories")
    private(set) var historySuggestions: [String] = []            
}

// MARK: - History Methods

extension SearchSuggestionManager {
    
    func addHistory(_ keyword: String) {
        if keyword.isEmpty {
            return
        }
        // 履歴にある場合は最新になるように再配置
        if let index = historySuggestions.firstIndex(where: { $0 == keyword }) {
            historySuggestions.remove(at: index)
            historySuggestions.insert(keyword, at: 0)
            return
        }
        
        // 履歴になければ検索された語句を追加
        historySuggestions.insert(keyword, at: 0)
        // 履歴の上限を超えた分を古い順に削除
        while historySuggestions.count > maxHistoryCount {
            historySuggestions.removeLast()
        }
    }
    
    func removeAllHistories() {
        historySuggestions.removeAll()
    }
}
