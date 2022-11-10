//
//  NameDescribable.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

// ref: [Get class name of object as string in Swift](https://stackoverflow.com/questions/24494784/get-class-name-of-object-as-string-in-swift)
protocol NameDescribable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension NameDescribable {
    var typeName: String {
        String(describing: type(of: self))
    }

    static var typeName: String {
        String(describing: self)
    }
}
