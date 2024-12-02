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

	func lcm() -> Int {
		let numbers = self
		func gcd(_ a: Int, _ b: Int) -> Int {
			var a = a
			var b = b
			while b != 0 {
				let temp = a % b
				a = b
				b = temp
			}
			return a
		}

		func lcm(_ a: Int, _ b: Int) -> Int {
			return a * b / gcd(a, b)
		}

		guard let firstNumber = numbers.first else {
			return 0
		}

		return numbers.dropFirst().reduce(firstNumber) { lcm($0, $1) }
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
