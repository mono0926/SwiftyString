//
//  UnicodeScalarExtensionTests.swift
//  SwiftyStringExtension
//
//  Created by mono on 2017/05/18.
//
//

import Foundation
import XCTest
import SwiftyString

class UnicodeScalarExtensionTests: XCTestCase {
    func testIsEmoji() {
        XCTAssertFalse("a".unicodeScalars.first!.ss.isEmoji)
        XCTAssertTrue("🐶".unicodeScalars.first!.ss.isEmoji)
        XCTAssertTrue("👨‍👩‍👧‍👧".unicodeScalars.first!.ss.isEmoji)
    }
}
