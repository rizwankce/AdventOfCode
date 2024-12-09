import Algorithms

struct Day09: AdventDay {
	var data: String

	var input: [Int] {
		data.digits
	}

	class DiskMap {
		var map: [Int: String]
		var x: Int
		var id: Int

		init(_ input: [Int]) {
			map = [:]
			x = 0
			id = 0

			for pair in zip([true, false].cycled(), input) {
				let (isFile, value) = pair
				for _ in 0..<value {
					if isFile {
						map[x] = "\(id)"
					}
					else {
						map[x] = "."
					}
					x += 1
				}
				if isFile {
					id += 1
				}
			}
		}

		func printMap() {
			var str = ""
			for i in 0..<x {
				str += map[i]!
			}
			print(str)
		}

		func checksum() -> Int {
			var sum = 0
			for i in 0..<x {
				if map[i] != "." {
					sum += (i * Int(map[i]!)!)
				}
			}
			return sum
		}

		func isGap() -> Bool {
			var result = false
			var empty = false
			for i in 0..<x {
				if map[i] == "." {
					empty = true
				}

				if empty && map[i] != "." {
					result = true
					break
				}
			}

			return result
		}

		func checksumByMovingOneBlock() -> Int {
			while isGap() {
				var cur: Int? = nil
				var ei: Int? = nil
				inner: for i in (0..<x).reversed() {
					if map[i] != "." {
						cur = i
						break inner
					}
				}

				inner2: for i in 0..<x {
					if map[i] == "." {
						ei = i
						break inner2
					}
				}

				if let cur = cur, let ei = ei {
					map[ei] = map[cur]
					map[cur] = "."
				}
			}
			return checksum()
		}

		func checksumByMovingFile() -> Int {
			var curId = id - 1
			while true {
				var cur: [Int] = []
				var ei: [Int] = []
				inner: for i in (0..<x) {
					if let v = map[i], v == "\(curId)" {
						cur.append(i)
					}
				}

				inner2: for i in 0..<x {
					if let v = map[i] {
						if v == "." {
							ei.append(i)
							if cur.count == ei.count {
								break inner2
							}
						}
						else if Int(v)! == curId {
							ei.removeAll()
							break inner2
						}
						else {
							ei.removeAll()
						}
					}
				}

				if cur.count != ei.count {
					ei.removeAll()
				}

				if !cur.isEmpty {
					if !ei.isEmpty {
						ei.forEach { map[$0] = "\(curId)" }
						cur.forEach { map[$0] = "." }
					}
				}
				else {
					break
				}
				curId -= 1
			}
			return checksum()
		}
	}

	func part1() -> Any {
		DiskMap(input).checksumByMovingOneBlock()
	}

	func part2() -> Any {
		DiskMap(input).checksumByMovingFile()
	}
}
