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
    public func snakeCased() -> String {
        return description.replacingOccurrences(of: "([A-Z])",
                                                with: "_$1",
                                                options: .regularExpression,
                                                range: description.startIndex ..< description.endIndex).lowercased()
    }
    public func validate() throws {
        // TODO: validate to be CamelCase
    }
}
