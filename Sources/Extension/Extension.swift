//
//  Extension.swift
//  SwiftyString
//
//  Created by mono on 2017/05/19.
//
//

import Foundation

public struct Extension<Base> {
    let base: Base
    init (_ base: Base) {
        self.base = base
    }
}

public protocol ExtensionCompatible {
    associatedtype Compatible
    static var ss: Extension<Compatible>.Type { get }
    var ss: Extension<Compatible> { get }
}

extension ExtensionCompatible {
    public static var ss: Extension<Self>.Type {
        return Extension<Self>.self
    }

    public var ss: Extension<Self> {
        get { return Extension(self) }
    }
}
