//: Playground - noun: a place where people can play

#if os(OSX)
    import Cocoa
#elseif os(iOS)
    import UIKit
#endif
import SwiftyString

var str = "Hello, playground"
str.ss[1..<3]
