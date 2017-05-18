//
//  StringTests.swift
//  SwiftyStringExtension
//
//  Created by mono on 2016/10/02.
//  Copyright © 2016 mono. All rights reserved.
//

import XCTest
import SwiftyStringExtension
import Foundation

class StringTests: XCTestCase {
    
    func testSuscript() {
        let input = "abcd"
        XCTAssertEqual(input[sequentialAccess: 0..<0], "")
        XCTAssertEqual(input[sequentialAccess: 0..<1], "a")
        XCTAssertEqual(input[sequentialAccess: 0..<2], "ab")
        XCTAssertEqual(input[sequentialAccess: 0..<3], "abc")
        XCTAssertEqual(input[sequentialAccess: 0..<4], input)
        XCTAssertEqual(input[sequentialAccess: 2..<2], "")
        XCTAssertEqual(input[sequentialAccess: 2..<3], "c")
        XCTAssertEqual(input[sequentialAccess: 2..<4], "cd")
        XCTAssertEqual(input[sequentialAccess: 0], "a")
        XCTAssertEqual(input[sequentialAccess: 3], "d")
    }
    
    func testToAsciiCode() {
        XCTAssertEqual("A".asciiCode, 65)
        XCTAssertEqual("a".asciiCode, 97)
        XCTAssertNil("".asciiCode)
        XCTAssertNil("ab".asciiCode)
        XCTAssertNil("あ".asciiCode)
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
        XCTAssertEqual(s1.makeNSRange(from: s1.startIndex..<s1.index(s1.startIndex, offsetBy: 2)).toRange()!, 0..<2)
        let s2 = "1️⃣2️⃣3️⃣4️⃣"
        XCTAssertEqual(s2.makeNSRange(from: s2.startIndex..<s2.index(s2.startIndex, offsetBy: 2)).toRange()!, 0..<6)
    }
    
    func testToRange() {
        let s1 = "abcd"
        XCTAssertEqual(s1.makeRange(from: NSRange(location: 0, length: 2)), s1.startIndex..<s1.index(s1.startIndex, offsetBy: 2))
        let s2 = "1️⃣2️⃣3️⃣4️⃣"
        XCTAssertEqual(s2.makeRange(from: NSRange(location: 0, length: 6)), s2.startIndex..<s2.index(s2.startIndex, offsetBy: 2))
        XCTAssertNil(s2.makeRange(from: NSRange(location: 0, length: 50)))
    }
    
    func testReplace() {
        var s = "abcd"
        s.replace(of: "cd", with: "ef")
        XCTAssertEqual(s, "abef")
        XCTAssertEqual(s, s.replacingOccurrences(of: "cd", with: "ef"))
    }
    
    func testAddingUrlEncoding() {
        let input1 = "abc"
        XCTAssertEqual(input1.addingUrlEncoding(), input1)
        let input2 = "http://hogehoge.com/?param=!*'();:@&=+$,/?%#[]"
        XCTAssertEqual(input2.addingUrlEncoding(), "http://hogehoge.com/?param=!*'();:@&=+$,/?%25%23%5B%5D")
    }
    
    func testGetValueOrNil() {
        XCTAssertEqual("a".getValueOrNil(), "a")
        XCTAssertNil("".getValueOrNil())
        let s: String? = nil
        XCTAssertNil(s?.getValueOrNil())
    }
    
    func testIsEmpty() {
        XCTAssertTrue(String.isEmpty(""))
        XCTAssertTrue(String.isEmpty(nil))
        XCTAssertFalse(String.isEmpty("a"))
    }
    
    func testCapitalizingFirstLetter() {
        XCTAssertEqual("aaBbCc".capitalizingFirstLetter, "AaBbCc")
        XCTAssertEqual("AaBbCc".capitalizingFirstLetter, "AaBbCc")
        XCTAssertEqual("aabbcc".capitalizingFirstLetter, "Aabbcc")
    }

    func testMultiplied() {
        XCTAssertEqual("ab".multiplied(3), "ababab")
    }
    func testReplacingFirst() {
        XCTAssertEqual("abcde".replacingFirst(2, with: "*"), "**cde")
    }
    func testReplacingLast() {
        XCTAssertEqual("abcde".replacingLast(2, with: "*"), "abc**")
    }

    func testIsSingleEmoji() {
        XCTAssertFalse("a".isSingleEmoji)
        XCTAssertTrue("🐶".isSingleEmoji)
        XCTAssertTrue("👨‍👩‍👧‍👧".isSingleEmoji)
    }

    func testContainsEmoji() {
        XCTAssertFalse("".containsEmoji)
        XCTAssertFalse("a".containsEmoji)
        XCTAssertTrue("🐶".containsEmoji)
        XCTAssertTrue("a🐶".containsEmoji)
        XCTAssertTrue("👨‍👩‍👧‍👧".containsEmoji)
    }

    func testContainsOnlyEmoji() {
        XCTAssertFalse("".containsOnlyEmoji)
        XCTAssertFalse("a".containsOnlyEmoji)
        XCTAssertTrue("🐶".containsOnlyEmoji)
        XCTAssertFalse("a🐶".containsOnlyEmoji)
        XCTAssertTrue("👨‍👩‍👧‍👧".containsOnlyEmoji)
    }
}
