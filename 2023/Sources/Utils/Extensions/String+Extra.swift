//
//  String+Extra.swift
//
//
//  Created by Rizwan on 01/12/23.
//

import Foundation

extension String {
    var numbers: [Int] {
        split(whereSeparator: { "-0123456789".contains($0) == false })
            .map { Int($0)! }
    }

    var lines: [String] {
        trimmingCharacters(in: .newlines)
            .components(separatedBy: .newlines)
    }

    var digits: [Int] {
        compactMap(\.wholeNumberValue)
    }
}
