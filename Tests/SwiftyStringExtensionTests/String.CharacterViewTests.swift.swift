//
//  String.CharacterViewTests.swift.swift
//  SwiftyStringExtension
//
//  Created by mono on 2016/10/02.
//  Copyright © 2016 mono. All rights reserved.
//

import XCTest
import SwiftyString

class CharacterViewTests: XCTestCase {
    
    func testSuscript() {
        let input = "abcd".characters
        XCTAssertTrue("bc".characters.elementsEqual(input.ss[1..<3]))
        XCTAssertEqual(input.ss[3], "d")
    }
}
