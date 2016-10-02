//
//  Tests.swift
//  Tests
//
//  Created by mono on 2016/10/02.
//  Copyright © 2016 mono. All rights reserved.
//

import XCTest
import SwiftyStringExtension

class Tests: XCTestCase {
    
    func testSuscript() {
        XCTAssertEqual("foo"[sequentialAccess: 0..<0], "")
        XCTAssertEqual("foo"[sequentialAccess: 0..<1], "f")
        XCTAssertEqual("foo"[sequentialAccess: 0..<2], "fo")
        XCTAssertEqual("foo"[sequentialAccess: 0..<3], "foo")
        XCTAssertEqual("foo"[sequentialAccess: 1..<1], "")
        XCTAssertEqual("foo"[sequentialAccess: 1..<2], "o")
        XCTAssertEqual("foo"[sequentialAccess: 1..<3], "oo")
    }
    
    func testToAsciiCode() {
        XCTAssertEqual("A".asciiCode, 65)
        XCTAssertEqual("a".asciiCode, 97)
    }
    
    func testFromAsciiCode() {
        XCTAssertEqual(Character(asciiCode: 65), "A")
        XCTAssertEqual(Character(asciiCode: 97), "a")
    }
    
    func testPrefix() {
        let input = "12345"
        XCTAssertEqual("1", input.prefix(upTo: input.index(input.startIndex, offsetBy: 1)))
        XCTAssertEqual(input, input.prefix(6))
    }
    
    func testRemoveBound() {
        var s = "abcde"
        s.removeFirst(2)
        XCTAssertEqual(s, "cde")
        s.removeLast(2)
        XCTAssertEqual(s, "c")
    }
}
