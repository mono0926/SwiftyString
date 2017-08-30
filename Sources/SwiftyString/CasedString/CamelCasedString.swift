//
//  CamelCase.swift
//  SwiftyString
//
//  Created by mono on 2017/08/30.
//

import Foundation


public struct CamelCasedString: CasedString {
    public let description: String
    public init?(_ description: String) {
        self.description = description
    }
    public init(stringLiteral description: String) {
        self.description = description
    }
    public func snakeCased() -> SnakeCasedString {
        return SnakeCasedString(description.replacingOccurrences(of: "([A-Z])",
                                                                 with: "_$1",
                                                                 options: .regularExpression,
                                                                 range: description.startIndex ..< description.endIndex).lowercased())! // TODO: should be nil or throws🤔
    }
    public func validate() throws {
        // TODO: validate to be CamelCase
    }
    public static func ==(lhs: CamelCasedString, rhs: CamelCasedString) -> Bool {
        return lhs.description == rhs.description
    }
}

