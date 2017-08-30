//
//  SnakeCase.swift
//  SwiftyString
//
//  Created by mono on 2017/08/30.
//

import Foundation

public struct SnakeCasedString: CasedString {
    public let description: String
    public init?(_ description: String) {
        self.description = description
    }
    public init(stringLiteral description: String) {
        self.description = description
    }
    public func camelCased() -> CamelCasedString {
        return CamelCasedString(description
            .components(separatedBy: "_")
            .enumerated()
            .map { i, s in i == 0 ? s : s.capitalized}
            .joined())! // TODO: should be nil or throws🤔
    }
    public func validate() throws {
        // TODO: validate to be SnakeCase
    }
    public static func ==(lhs: SnakeCasedString, rhs: SnakeCasedString) -> Bool {
        return lhs.description == rhs.description
    }
}
