//
//  CasedStringTests.swift
//  Tests
//
//  Created by mono on 2017/08/30.
//

import XCTest
import SwiftyString
import Foundation

class CasedStringTests: XCTestCase {
    func testCamel2SnakeCase() {
        let target: CamelCasedString = "helloMonoWorld2"
        let snakeCased = target.snakeCased()
        XCTAssertEqual(snakeCased, "hello_mono_world2")
    }

    func testSnake2CamelCase() {
        let target: SnakeCasedString = "hello_mono_world2"
        let camelCased = target.camelCased()
        XCTAssertEqual(camelCased, "helloMonoWorld2")
    }
}
