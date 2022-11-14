//
//  MessageError.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/14.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

// ref: https://ikeh1024.hatenablog.com/entry/2022/11/14/155956
struct MessageError: Swift.Error, CustomStringConvertible {
    var description: String
}
