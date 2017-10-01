//
//  Substring.extension.swift
//  SwiftyString
//
//  Created by mono on 2017/10/01.
//

import Foundation

#if os(Linux)
extension Substring {
    public var capitalized: String { return String(self).capitalized }
}
#endif
