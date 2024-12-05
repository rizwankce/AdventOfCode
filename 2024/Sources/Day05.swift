import Algorithms

struct Day05: AdventDay {
	var data: String

	var input: [String] {
		data.components(separatedBy: "\n\n")
	}

	var rules: [[Int]] {
		input[0].components(separatedBy: "\n").map {
			$0.components(separatedBy: "|")
				.compactMap(Int.init)
		}
	}

	var pages: [[Int]] {
		input[1].components(separatedBy: "\n").map {
			$0.components(separatedBy: ",")
				.compactMap(Int.init)
		}.filter { !$0.isEmpty }
	}

	func isValid(page: [Int]) -> Bool {
		var valid = true
		for i in 0..<page.count {
			for j in i..<page.count {
				if i != j {
					let left = page[i]
					let right = page[j]

					for rule in rules {
						if rule.contains(left) && rule.contains(right) {
							if rule[0] != left && rule[1] != right {
								valid = false
							}
						}
					}
				}
			}
		}
		return valid
	}

	func part1() -> Any {
		pages
			.filter { isValid(page: $0) }
			.map { page in
				page[(page.count - 1) / 2]
			}
			.reduce(0, +)
	}

	func part2() -> Any {
		var result = 0
		for page in pages {
			if !isValid(page: page) {
				var page = page
				for i in 0..<page.count {
					for j in i..<page.count {
						if i != j {
							let left = page[i]
							let right = page[j]
							for rule in rules {
								if rule.contains(left)
									&& rule.contains(right)
								{
									if rule[0] != left
										&& rule[1] != right
									{
										page[i] = rule[0]
										page[j] = rule[1]
									}
								}
							}
						}
					}
				}
				result += page[(page.count - 1) / 2]
			}
		}
		return result
	}
}
