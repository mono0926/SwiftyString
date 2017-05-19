//
//  String.CharacterView.extension.swift
//  SwiftyStringExtension
//
//  Created by mono on 2016/10/02.
//  Copyright © 2016 mono. All rights reserved.
//

import Foundation

extension String.CharacterView: ExtensionCompatible {}

extension Extension where Base == String.CharacterView {
    
    public subscript(range: Range<Int>) -> String.CharacterView {
        let lower = range.lowerBound
        let startIndex = base.index(base.startIndex, offsetBy: lower)
        let endIndex = base.index(startIndex, offsetBy: range.count)
        return base[startIndex..<endIndex]
    }
    
    public subscript(index: Int) -> Character {
        return self[index..<index + 1].first!
    }
    
}
