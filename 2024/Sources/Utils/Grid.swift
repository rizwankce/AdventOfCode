//
//  Grid2d.swift
//
//
//  Created by Rizwan on 01/12/23.
//

class Grid2d<T: Equatable>: CustomStringConvertible, Equatable {
	static func == (lhs: Grid2d<T>, rhs: Grid2d<T>) -> Bool {
		lhs.grid == rhs.grid
	}

	typealias Cell = [Point: T]

	var grid: Cell = [:]
	let rowCount: Int
	let colCount: Int
	let rawInput: [String]

	subscript(point: Point) -> T? {
		get {
			grid[point]
		}
		set(newValue) {
			grid[point] = newValue
		}
	}

	init(_ input: [String]) {
		self.rawInput = input
		self.rowCount = input.count
		self.colCount = input[0].count

		input.enumerated().forEach { (i, line) in
			line.enumerated().forEach { (j, char) in
				let p = Point.init(x: j, y: i)
				grid[p] = char as? T
			}
		}
	}

	init(_ grid: [Point: T]) {
		self.grid = grid
		self.rowCount = grid.keys.map { $0.y }.max()! + 1
		self.colCount = grid.keys.map { $0.x }.max()! + 1

		var input: [String] = []
		for c in 0..<colCount {
			var line = ""
			for r in 0..<rowCount {
				let p = Point(x: c, y: r)
				line += grid[p] as! String
			}
			input.append(line)
		}
		self.rawInput = input
	}

	func debugPrint() {
		print(description)
	}

	func getColumns(_ c: Int) -> [Point] {
		(0..<rowCount).map { Point(x: c, y: $0) }
	}

	func getRows(_ r: Int) -> [Point] {
		(0..<colCount).map { Point(x: $0, y: r) }
	}

	func isValid(_ point: Point) -> Bool {
		grid.keys.contains(point)
	}

	func neighbours(_ p: Point) -> [Point] {
		p.neighbours()
	}

	func adjacents(_ p: Point) -> [Point] {
		p.adjacent()
	}

	func adjacentValues(_ p: Point) -> [T] {
		p.adjacent().compactMap { grid[$0] }
	}

	func neighbourValues(_ p: Point) -> [T] {
		p.neighbours().compactMap { grid[$0] }
	}

	var description: String {
		var result = ""
		result += "grid start" + "\n"
		result += "rc" + "  "
		(0..<colCount).forEach {
			result += "\($0)" + " "
		}
		result += "\n\n"
		rawInput.enumerated().forEach { (i, line) in
			result += "\(i)" + "  " + (i < 10 ? " " : "")
			line.enumerated().forEach { (j, char) in
				let p = Point.init(x: j, y: i)
				if let char = grid[p] as? Character {
					result += String(char) + " "
				}
				if j > 9 {
					result += " "
				}
			}
			result += "\n"
		}
		return result
	}
}
