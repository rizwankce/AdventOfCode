//
//  Point.swift
//
//
//  Created by Rizwan on 01/12/23.
//

import Foundation

struct Point: CustomStringConvertible, Equatable, Hashable {
	var x: Int
	var y: Int

	var description: String {
		return "(X:\(self.x) Y:\(self.y))"
	}

	// [(X:-1 Y:-1), (X:-1 Y:0), (X:-1 Y:1), (X:0 Y:-1), (X:0 Y:1), (X:1 Y:-1), (X:1 Y:0), (X:1 Y:1)]
	func neighbours() -> [Point] {
		var points: [Point] = []
		for x in [-1, 0, 1] {
			for y in [-1, 0, 1] {
				points.append(Point.init(x: self.x + x, y: self.y + y))
			}
		}
		points.removeAll(where: { $0 == self })
		return points
	}

	// [(X:-1 Y:0), (X:0 Y:-1), (X:0 Y:1), (X:1 Y:0)]
	func adjacent() -> [Point] {
		var points: [Point] = []
		for x in [-1, 0, 1] {
			for y in [-1, 0, 1] {
				if x == 0 || y == 0 {
					points.append(Point.init(x: self.x + x, y: self.y + y))
				}
			}
		}
		points.removeAll(where: { $0 == self })
		return points
	}

	static let start = Point(x: 0, y: 0)
}

extension Point {
	func distance(_ point: Point) -> Int {
		abs(x - point.x) + abs(y - point.y)
	}
}

// MARK: -  Direction

extension Point {
	mutating func move(_ count: Int, _ dir: Direction) {
		switch dir {
		case .east: x += count
		case .west: x -= count
		case .south: y += count
		case .north: y -= count
		default: fatalError()
		}
	}

	func moved(_ count: Int, _ dir: Direction) -> Point {
		var copy = self
		copy.move(count, dir)
		return copy
	}
}

enum Direction: String {
	case east = "E"
	case west = "W"
	case south = "S"
	case north = "N"
	case left = "L"
	case right = "R"
	case forward = "F"

	mutating func turn(_ deg: Int, _ dir: Direction) {

		assert(deg != 90 || deg != 180 || deg != 270)

		switch self {
		case .east:
			if deg == 90 {
				if dir == .right {
					self = .south
				}
				if dir == .left {
					self = .north
				}
			}

			if deg == 270 {
				if dir == .right {
					self = .north
				}
				if dir == .left {
					self = .south
				}
			}

			if deg == 180 {
				self = .west
			}

		case .west:
			if deg == 90 {
				if dir == .right {
					self = .north
				}
				if dir == .left {
					self = .south
				}
			}

			if deg == 270 {
				if dir == .right {
					self = .south
				}
				if dir == .left {
					self = .north
				}
			}

			if deg == 180 {
				self = .east
			}

		case .south:
			if deg == 90 {
				if dir == .right {
					self = .west
				}
				if dir == .left {
					self = .east
				}
			}

			if deg == 180 {
				self = .north
			}

			if deg == 270 {
				if dir == .right {
					self = .east
				}
				if dir == .left {
					self = .west
				}
			}
		case .north:
			if deg == 90 {
				if dir == .right {
					self = .east
				}
				if dir == .left {
					self = .west
				}
			}

			if deg == 270 {
				if dir == .right {
					self = .west
				}
				if dir == .left {
					self = .east
				}
			}

			if deg == 180 {
				self = .south
			}

		default:
			fatalError()
		}
	}
}
