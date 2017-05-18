//
//  UnicodeScalarExtensionTests.swift
//  SwiftyStringExtension
//
//  Created by mono on 2017/05/18.
//
//

import Foundation
import XCTest
import SwiftyStringExtension

class UnicodeScalarExtensionTests: XCTestCase {
    func testIsEmoji() {
        XCTAssertFalse("a".unicodeScalars.first!.isEmoji)
        XCTAssertTrue("🐶".unicodeScalars.first!.isEmoji)
        XCTAssertTrue("👨‍👩‍👧‍👧".unicodeScalars.first!.isEmoji)
    }
}
