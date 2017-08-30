//
//  CasedString.swift
//  SwiftyString
//
//  Created by mono on 2017/08/30.
//

import Foundation

public protocol CasedString: LosslessStringConvertible, ExpressibleByStringLiteral, Equatable {
    // 無くて良いかも
    func validate() throws
}
