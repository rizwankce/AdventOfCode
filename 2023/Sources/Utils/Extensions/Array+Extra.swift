//
//  Array+Extra.swift
//
//
//  Created by Rizwan on 01/12/23.
//

import Foundation

// MARK: - Array int value

extension Array where Element == Int {
    var intValue: Int {
        var value = 0
        for element in self {
            value *= 2
            value += element
        }
        return value
    }
}

// MARK: - Uniques from Array

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
