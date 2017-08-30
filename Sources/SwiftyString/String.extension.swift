//
//  String.extension.swift
//  nlp100-swift
//
//  Created by mono on 2016/10/01.
//
//

import Foundation
import CoreText

extension Optional where Wrapped == String {
    public var isEmpty: Bool { return self?.isEmpty ?? true }
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

extension String {

    // MARK: - Subscript
    public subscript(sequentialAccess range: Range<Int>) -> String {
        return String(characters[sequentialAccess: range])
    }

    public subscript(sequentialAccess index: Int) -> String {
        return self[sequentialAccess: index..<index + 1]
    }

    // MARK: - Other
    public var asciiCode: UInt32? {
        if unicodeScalars.index(after: unicodeScalars.startIndex) != unicodeScalars.endIndex { return nil }
        return characters.first?.asciiCode
    }

    // MARK: - Convenient
    public func addingUrlEncoding() -> String {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    public func getValueOrNil() -> String? {
        if isEmpty {
            return nil
        }
        return self
    }
    public func multiplied(_ n: Int) -> String {
        return String(repeating: self, count: n)
    }
    public func replacingFirst(_ n: Int, with char: Character) -> String {
        return String(char).multiplied(n) + dropFirst(n)
    }
    public func replacingLast(_ n: Int, with char: Character) -> String {
        return dropLast(n) + String(char).multiplied(n)
    }

    public var capitalizingFirstLetter: String {
        return prefix(1).capitalized + dropFirst()
    }

    // MARK: - Emoji

    public var glyphCount: Int {
        let richText = NSAttributedString(string: self)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }

    public var isSingleEmoji: Bool { return glyphCount == 1 && containsEmoji }
    public var containsEmoji: Bool { return !unicodeScalars.filter { $0.isEmoji }.isEmpty }
    public var containsOnlyEmoji: Bool { return
        !isEmpty && unicodeScalars.first { !$0.isEmoji && !$0.isZeroWidthJoiner } == nil
    }
    public var emojiString: String { return emojiScalars.map { String($0) }.joined(separator: "") }
    public var emojis: [String] {
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?
        for scalar in emojiScalars {
            if let prev = previousScalar, !prev.isZeroWidthJoiner && !scalar.isZeroWidthJoiner {
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
        for cur in unicodeScalars {
            if let previous = previous, previous.isZeroWidthJoiner && cur.isEmoji {
                chars.append(previous)
                chars.append(cur)
            } else if cur.isEmoji {
                chars.append(cur)
            }
            previous = cur
        }
        return chars
    }
}

