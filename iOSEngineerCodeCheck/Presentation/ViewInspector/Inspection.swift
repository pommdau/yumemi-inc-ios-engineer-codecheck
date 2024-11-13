//
//  Inspection.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/12/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Combine
import SwiftUI

internal final class Inspection<V> {
    let notice = PassthroughSubject<UInt, Never>()
    var callbacks: [UInt: (V) -> Void] = [:]
    
    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}
