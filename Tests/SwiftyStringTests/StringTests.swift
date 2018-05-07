//
//  StringTests.swift
//  SwiftyString
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
        var target: String? = nil
        XCTAssertTrue(target.isEmpty)
        target = ""
        XCTAssertTrue(target.isEmpty)
        target = "a"
        XCTAssertFalse(target.isEmpty)
    }
    
    func testCapitalizingFirstLetter() {
        XCTAssertEqual("aaBbCc".capitalizingFirstLetter, "AaBbCc")
        XCTAssertEqual("AaBbCc".capitalizingFirstLetter, "AaBbCc")
        XCTAssertEqual("aabbcc".capitalizingFirstLetter, "Aabbcc")
    }

    func testRanges() throws {
        let s = "🐶👪"
        let text = "hello \(s) and \(s)"
        let ranges: [Range<String.Index>] = try text.ranges(of: s)
        XCTAssertEqual(ranges.count, 2)
        XCTAssertEqual(ranges[0].lowerBound, text.index(text.startIndex, offsetBy: 6))
        XCTAssertEqual(ranges[0].upperBound, text.index(text.startIndex, offsetBy: 8))
        XCTAssertEqual(ranges[1].lowerBound, text.index(text.startIndex, offsetBy: 13))
        XCTAssertEqual(ranges[1].upperBound, text.index(text.startIndex, offsetBy: 15))
    }

    func testRanges_empty() throws {
        let s = "🐶👪"
        let text = ""
        let ranges: [Range<String.Index>] = try text.ranges(of: s)
        XCTAssertEqual(ranges.count, 0)
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

    #if os(macOS)
    func testIsSingleEmoji() {
        XCTAssertFalse("a".isSingleEmoji)
        XCTAssertTrue("🐶".isSingleEmoji)
        XCTAssertTrue("👨‍👩‍👧‍👧".isSingleEmoji)
        XCTAssertTrue("1️⃣".isSingleEmoji)
    }
    #endif

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
