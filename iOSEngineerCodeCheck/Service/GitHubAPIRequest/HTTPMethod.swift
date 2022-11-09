//
//  HTTPMethod.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case head    = "HEAD"
    case delete  = "DELETE"
    case patch   = "PATCH"
    case trace   = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"
}
