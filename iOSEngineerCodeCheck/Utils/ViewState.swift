//
//  ViewState.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/14.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//
//  refs: https://github.com/fuxlud/Modularized_iOS_App/blob/f1a0fd24b508dfa49e7ee6383404adf8ba34361a/Submodules/Sources/InfrastructureLayer/Architecture/ViewState.swift#L4

import Foundation
import SwiftUI

// MARK: - ViewState

enum ViewState<Value> {
    case idle(Value?) // まだデータを取得しにいっていない、前回のデータがあれば保持
    case loading // 読み込み中
    case failed(Error) // 読み込み失敗、遭遇したエラーを保持
    case loaded(Value) // 読み込み完了、読み込まれたデータを保持
}

// MARK: - Computed Property

extension ViewState {
    var data: Value? {
        switch self {
        case .idle(let data):
            return data
        case .loaded(let data):
            return data
        default:
            return nil
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
    
    var error: Error? {
        switch self {
        case .failed(let error):
            return error
        default:
            return nil
        }
    }
}
