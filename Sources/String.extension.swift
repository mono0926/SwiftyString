//
//  String.extension.swift
//  nlp100-swift
//
//  Created by mono on 2016/10/01.
//
//

import Foundation
import CoreText

extension String: ExtensionCompatible {}
extension Optional: ExtensionCompatible {}

extension Extension where Base == Optional<String> {
    public var isEmpty: Bool { return base?.isEmpty ?? true }
}

extension String {
    // MARK: - Bug?
    public mutating func removeFirst(_ n: Int) {
        characters.removeFirst(n)
    }
    public mutating func removeLast(_ n: Int) {
        characters.removeLast(n)
    }
    // MARK: - Convenient
    public mutating func replace(of target: String, with replacement: String)  {
        self = replacingOccurrences(of: target, with: replacement)
    }
}

extension Extension where Base == String {
    
    // MARK: - Subscript
    public subscript(range: Range<Int>) -> String {
        return String(base.characters.ss[range])
    }
    
    public subscript(index: Int) -> String {
        return self[index..<index + 1]
    }
    
    // MARK: - Other    
    public var asciiCode: UInt32? {
        if base.unicodeScalars.index(after: base.unicodeScalars.startIndex) != base.unicodeScalars.endIndex { return nil }
        return base.characters.first?.ss.asciiCode
    }
    
    // MARK: - Range
    public func makeNSRange(from range: Range<String.Index>) -> NSRange {
        let utf16 = base.utf16
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    public func makeRange(from range: NSRange) -> Range<String.Index>? {
        let utf16 = base.utf16
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: base),
            let to = String.Index(to16, within: base)
            else { return nil }
        return from ..< to
    }
    
    // MARK: - Convenient
    public func addingUrlEncoding() -> String {
        return base.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    public func getValueOrNil() -> String? {
        if base.isEmpty {
            return nil
        }
        return base
    }
    public func multiplied(_ n: Int) -> String {
        return String(repeating: base, count: n)
    }
    public func replacingFirst(_ n: Int, with char: Character) -> String {
        return String(char).ss.multiplied(n) + base.dropFirst(n)
    }
    public func replacingLast(_ n: Int, with char: Character) -> String {
        return base.dropLast(n) + String(char).ss.multiplied(n)
    }
    
    public var capitalizingFirstLetter: String {
        return base.prefix(1).capitalized + base.dropFirst()
    }

    // MARK: - Emoji

    public var glyphCount: Int {
        let richText = NSAttributedString(string: base)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }

    public var isSingleEmoji: Bool { return glyphCount == 1 && containsEmoji }
    public var containsEmoji: Bool { return !base.unicodeScalars.filter { $0.ss.isEmoji }.isEmpty }
    public var containsOnlyEmoji: Bool { return
        !base.isEmpty && base.unicodeScalars.first { !$0.ss.isEmoji && !$0.ss.isZeroWidthJoiner } == nil
    }
    public var emojiString: String { return emojiScalars.map { String($0) }.joined(separator: "") }
    public var emojis: [String] {
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?
        for scalar in emojiScalars {
            if let prev = previousScalar, !prev.ss.isZeroWidthJoiner && !scalar.ss.isZeroWidthJoiner {
                scalars.append(currentScalarSet)
                currentScalarSet = []
            }
            currentScalarSet.append(scalar)
            previousScalar = scalar
        }
        scalars.append(currentScalarSet)
        return scalars.map { $0.map{ String($0) } .reduce("", +) }
    }

    fileprivate var emojiScalars: [UnicodeScalar] {
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in base.unicodeScalars {
            if let previous = previous, previous.ss.isZeroWidthJoiner && cur.ss.isEmoji {
                chars.append(previous)
                chars.append(cur)
            } else if cur.ss.isEmoji {
                chars.append(cur)
            }
            previous = cur
        }
        return chars
    }
}
