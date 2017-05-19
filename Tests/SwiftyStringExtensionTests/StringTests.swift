//
//  StringTests.swift
//  SwiftyStringExtension
//
//  Created by mono on 2016/10/02.
//  Copyright © 2016 mono. All rights reserved.
//

import XCTest
import SwiftyString
import Foundation

class StringTests: XCTestCase {
    
    func testSuscript() {
        let input = "abcd"
        XCTAssertEqual(input.ss[0..<0], "")
        XCTAssertEqual(input.ss[0..<1], "a")
        XCTAssertEqual(input.ss[0..<2], "ab")
        XCTAssertEqual(input.ss[0..<3], "abc")
        XCTAssertEqual(input.ss[0..<4], input)
        XCTAssertEqual(input.ss[2..<2], "")
        XCTAssertEqual(input.ss[2..<3], "c")
        XCTAssertEqual(input.ss[2..<4], "cd")
        XCTAssertEqual(input.ss[0], "a")
        XCTAssertEqual(input.ss[3], "d")
    }
    
    func testToAsciiCode() {
        XCTAssertEqual("A".ss.asciiCode, 65)
        XCTAssertEqual("a".ss.asciiCode, 97)
        XCTAssertNil("".ss.asciiCode)
        XCTAssertNil("ab".ss.asciiCode)
        XCTAssertNil("あ".ss.asciiCode)
    }
    
    func testRemoveBound() {
        var s = "abcde"
        s.removeFirst(2)
        XCTAssertEqual(s, "cde")
        s.removeLast(2)
        XCTAssertEqual(s, "c")
    }
    
    func testToNSRange() {
        let s1 = "abcd"
        XCTAssertEqual(s1.ss.makeNSRange(from: s1.startIndex..<s1.index(s1.startIndex, offsetBy: 2)).toRange()!, 0..<2)
        let s2 = "1️⃣2️⃣3️⃣4️⃣"
        XCTAssertEqual(s2.ss.makeNSRange(from: s2.startIndex..<s2.index(s2.startIndex, offsetBy: 2)).toRange()!, 0..<6)
    }
    
    func testToRange() {
        let s1 = "abcd"
        XCTAssertEqual(s1.ss.makeRange(from: NSRange(location: 0, length: 2)), s1.startIndex..<s1.index(s1.startIndex, offsetBy: 2))
        let s2 = "1️⃣2️⃣3️⃣4️⃣"
        XCTAssertEqual(s2.ss.makeRange(from: NSRange(location: 0, length: 6)), s2.startIndex..<s2.index(s2.startIndex, offsetBy: 2))
        XCTAssertNil(s2.ss.makeRange(from: NSRange(location: 0, length: 50)))
    }
    
    func testReplace() {
        var s = "abcd"
        s.replace(of: "cd", with: "ef")
        XCTAssertEqual(s, "abef")
        XCTAssertEqual(s, s.replacingOccurrences(of: "cd", with: "ef"))
    }
    
    func testAddingUrlEncoding() {
        let input1 = "abc"
        XCTAssertEqual(input1.ss.addingUrlEncoding(), input1)
        let input2 = "http://hogehoge.com/?param=!*'();:@&=+$,/?%#[]"
        XCTAssertEqual(input2.ss.addingUrlEncoding(), "http://hogehoge.com/?param=!*'();:@&=+$,/?%25%23%5B%5D")
    }
    
    func testGetValueOrNil() {
        XCTAssertEqual("a".ss.getValueOrNil(), "a")
        XCTAssertNil("".ss.getValueOrNil())
        let s: String? = nil
        XCTAssertNil(s?.ss.getValueOrNil())
    }
    
    func testIsEmpty() {
        var target: String? = nil
        XCTAssertTrue(target.ss.isEmpty)
        target = ""
        XCTAssertTrue(target.ss.isEmpty)
        target = "a"
        XCTAssertFalse(target.ss.isEmpty)
    }
    
    func testCapitalizingFirstLetter() {
        XCTAssertEqual("aaBbCc".ss.capitalizingFirstLetter, "AaBbCc")
        XCTAssertEqual("AaBbCc".ss.capitalizingFirstLetter, "AaBbCc")
        XCTAssertEqual("aabbcc".ss.capitalizingFirstLetter, "Aabbcc")
    }

    func testMultiplied() {
        XCTAssertEqual("ab".ss.multiplied(3), "ababab")
    }
    func testReplacingFirst() {
        XCTAssertEqual("abcde".ss.replacingFirst(2, with: "*"), "**cde")
    }
    func testReplacingLast() {
        XCTAssertEqual("abcde".ss.replacingLast(2, with: "*"), "abc**")
    }

    func testIsSingleEmoji() {
        XCTAssertFalse("a".ss.isSingleEmoji)
        XCTAssertTrue("🐶".ss.isSingleEmoji)
        XCTAssertTrue("👨‍👩‍👧‍👧".ss.isSingleEmoji)
    }

    func testContainsEmoji() {
        XCTAssertFalse("".ss.containsEmoji)
        XCTAssertFalse("a".ss.containsEmoji)
        XCTAssertTrue("🐶".ss.containsEmoji)
        XCTAssertTrue("a🐶".ss.containsEmoji)
        XCTAssertTrue("👨‍👩‍👧‍👧".ss.containsEmoji)
    }

    func testContainsOnlyEmoji() {
        XCTAssertFalse("".ss.containsOnlyEmoji)
        XCTAssertFalse("a".ss.containsOnlyEmoji)
        XCTAssertTrue("🐶".ss.containsOnlyEmoji)
        XCTAssertFalse("a🐶".ss.containsOnlyEmoji)
        XCTAssertTrue("👨‍👩‍👧‍👧".ss.containsOnlyEmoji)
    }
}
