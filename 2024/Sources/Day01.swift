import Algorithms

struct Day01: AdventDay {
	var data: String

	private var input: [(Int, Int)] {
		data
			.split(separator: "\n")
			.map { $0.split(separator: " ").map(String.init) }
			.compactMap { components -> (Int, Int)? in
				guard components.count == 2,
					let first = Int(components[0]),
					let second = Int(components[1])
				else {
					return nil
				}
				return (first, second)
			}
	}

	func part1() -> Any {
		let sortedL1 = input.map { $0.0 }.sorted()
		let sortedL2 = input.map { $0.1 }.sorted()

		let totalDifference = zip(sortedL1, sortedL2)
			.map { abs($0 - $1) }
			.reduce(0, +)

		return totalDifference
	}

	func part2() -> Any {
		let l1 = input.map { $0.0 }
		let l2 = input.map { $0.1 }

		let frequencyL2 = l2.reduce(into: [Int: Int]()) { counts, number in
			counts[number, default: 0] += 1
		}

		let total = l1.reduce(0) { sum, number in
			let count = frequencyL2[number] ?? 0
			return sum + (number * count)
		}

		return total
	}
}
