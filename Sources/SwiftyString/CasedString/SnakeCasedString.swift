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
    public func camelCased() -> String {
        return description
            .components(separatedBy: "_")
            .enumerated()
            .map {0 == $0 ? $1 : $1.capitalized}
            .joined()
    }
    public func validate() throws {
        // TODO: validate to be SnakeCase
    }
}
