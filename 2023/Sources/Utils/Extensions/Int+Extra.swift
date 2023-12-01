//
//  Int+Extra.swift
//  
//
//  Created by Rizwan on 01/12/23.
//

import Foundation

// MARK: - Int to Bits

extension Int {
    var bits: [Int] {
        var array: [Int] = []
        var copy = self
        while copy > 0 {
            array.append(copy % 2)
            copy /= 2
        }
        return array.reversed()
    }
}
