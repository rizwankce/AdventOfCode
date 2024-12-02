import Algorithms

struct Day02: AdventDay {
	var data: String

	var input: [[Int]] {
		data.lines.map { line in
			line.components(separatedBy: " ").compactMap { Int($0) }
		}
	}

	enum LevelDirection {
		case increase
		case decrease
		case none
	}

	func isSafe(_ level: [Int]) -> Bool {
		var isValid = false
		var direction: LevelDirection = .none

		for i in 0..<level.count - 1 {
			let cur = level[i]
			let next = level[i + 1]
			if ![1, 2, 3].contains(abs(cur - next)) {
				isValid = false
				break
			}

			if cur - next == 0 {
				isValid = false
				break
			}

			if cur - next > 0 {
				if direction == .decrease {
					isValid = false
					break
				}
				direction = .increase
				isValid = true
			}
			if cur - next < 0 {
				if direction == .increase {
					isValid = false
					break
				}
				direction = .decrease
				isValid = true
			}
		}
		return isValid
	}

	func part1() -> Any {
		input
			.filter { isSafe($0) }
			.count
	}

	func part2() -> Any {
		var result = 0
		for levels in input {
			if !isSafe(levels) {
				var cur = levels
				inner: for index in 0..<levels.count {
					cur.remove(at: index)
					if isSafe(cur) {
						result += 1
						break inner
					}
					cur = levels
				}
			}
			else {
				result += 1
			}
		}
		return result
	}
}
