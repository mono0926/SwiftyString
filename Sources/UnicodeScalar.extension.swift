//
//  UnicodeScalar.extension.swift
//  SwiftyStringExtension
//
//  Created by mono on 2017/05/18.
//
//

import Foundation

extension UnicodeScalar: ExtensionCompatible {}

extension Extension where Base == UnicodeScalar {
    public var isEmoji: Bool {
        switch base.value {
        case 0x3030, 0x00AE, 0x00A9, // Special Characters
        0x1D000 ... 0x1F77F, // Emoticons
        0x2100 ... 0x27BF, // Misc symbols and Dingbats
        0xFE00 ... 0xFE0F, // Variation Selectors
        0x1F900 ... 0x1F9FF: // Supplemental Symbols and Pictographs
            return true
        default: return false
        }
    }
    public var isZeroWidthJoiner: Bool { return base.value == 8205 }
}