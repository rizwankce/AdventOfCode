import Algorithms
import Foundation
import RegexBuilder

struct Day03: AdventDay {
	var data: String

	// xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
	func part1() -> Any {
		var result = 0
		let regex = Regex {
			"mul("
			Capture {
				Repeat(1...3) {
					One(.digit)
				}
			}
			","
			Capture {
				Repeat(1...3) {
					One(.digit)
				}
			}
			")"
		}.anchorsMatchLineEndings()

		for match in data.matches(of: regex) {
			let output = match.output
			result += (Int(output.1)! * Int(output.2)!)
		}

		return result
	}

	func part2() -> Any {
		var result = 0
		var enabled = true

		let regex = Regex {
			Anchor.startOfLine
			"mul("
			Capture {
				Repeat(1...3) {
					One(.digit)
				}
			}
			","
			Capture {
				Repeat(1...3) {
					One(.digit)
				}
			}
			")"
		}.anchorsMatchLineEndings()

		for index in data.indices {
			let cur = data[index..<data.endIndex]
			if cur.hasPrefix("do()") {
				enabled = true
			}
			else if cur.hasPrefix("don't()") {
				enabled = false
			}

			if enabled {
				if let output = cur.firstMatch(of: regex)?.output {
					result += (Int(output.1)! * Int(output.2)!)
				}
			}
		}
		return result
	}
}
