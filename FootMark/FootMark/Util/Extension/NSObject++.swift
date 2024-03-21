//
//  NSObject++.swift
//  FootMark
//
//  Created by 박신영 on 3/21/24.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
