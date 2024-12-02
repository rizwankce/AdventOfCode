//
//  Utils.swift
//
//
//  Created by Rizwan on 01/12/23.
//

import Foundation

// MARK: - Comparing two dictionary

public func == <K, L: Hashable, R: Hashable>(lhs: [K: L], rhs: [K: R]) -> Bool {
	(lhs as NSDictionary).isEqual(to: rhs)
}

// MARK: - Combinators

func combos<T>(elements: ArraySlice<T>, k: Int) -> [[T]] {
	if k == 0 {
		return [[]]
	}

	guard let first = elements.first else {
		return []
	}

	let head = [first]
	let subcombos = combos(elements: elements, k: k - 1)
	var ret = subcombos.map { head + $0 }
	ret += combos(elements: elements.dropFirst(), k: k)

	return ret
}

func combos<T>(elements: [T], k: Int) -> [[T]] {
	return combos(elements: ArraySlice(elements), k: k)
}
