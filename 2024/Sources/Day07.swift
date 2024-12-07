import Algorithms

struct Day07: AdventDay {
	var data: String
	/*
     190: 10 19
     3267: 81 40 27
     83: 17 5
     156: 15 6
     7290: 6 8 6 15
     161011: 16 10 13
     192: 17 8 14
     21037: 9 7 18 13
     292: 11 6 16 20
     */

	var equations: [Equation] {
		data.lines.map { Equation($0) }
	}

	enum Operator: String, CaseIterable {
		case multiply = "*"
		case add = "+"
		case concat = "||"
	}

	struct Equation {
		let result: Int
		let numbers: [Int]

		init(_ line: String) {
			let com = line.components(separatedBy: ": ")
			self.result = Int(com[0])!
			self.numbers = com[1].split(separator: " ").compactMap { Int($0) }
		}

		func solve(_ op: [Operator]) -> Int {
			// [10,19]
			// ["*"],["+"]

			//[81, 40, 27] ["+", "+"]
			var left = numbers[0]
			var i = 1
			var j = 0
			while i < numbers.count {
				let right = numbers[i]
				let o = op[j]
				switch o {
				case .add:
					left = left + right
				case .multiply:
					left = left * right
				case .concat:
					left = Int("\(left)\(right)")!
				}
				j += 1
				i += 1
			}
			return left
		}

		func isTrue(_ op: [Operator]) -> Bool {
			solve(op) == result
		}
	}

	func combos(operators: [Operator], count: Int) -> [[Operator]] {
		// 2 +*,+*,++,** = 4
		// 3 ***,+++,**+,*+*,+**,*++,++*,+*+ = 8
		var result: [[Operator]] = []

		func backtrack(current: [Operator]) {
			if current.count == count {
				result.append(current)
				return
			}

			for op in operators {
				backtrack(current: current + [op])
			}
		}

		backtrack(current: [])
		return result
	}

	func part1() -> Any {
		var ans = 0
		for eq in equations {
			for c in combos(operators: [.add, .multiply], count: eq.numbers.count - 1) {
				if eq.isTrue(c) {
					ans += eq.result
					break
				}
			}
		}
		return ans
	}

	func part2() -> Any {
		var ans = 0
		for eq in equations {
			for c in combos(operators: Operator.allCases, count: eq.numbers.count - 1) {
				if eq.isTrue(c) {
					ans += eq.result
					break
				}
			}
		}
		return ans
	}
}
