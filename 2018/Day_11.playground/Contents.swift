import Cocoa
import Foundation

let input = """
9445
"""

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }
}

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}

func get3x3Grid(_ point: Point) -> [Point] {
    if point.x > 297 || point.y > 297 {
        return []
    }

    var points: [Point] = []
    for x in point.x ..< point.x+3 {
        for y in point.y ..< point.y+3 {
            points.append(Point.init(x: x, y: y))
        }
    }
    return points
}

func powerLevel(_ point: Point, _ serial: Int) -> Int {
    let rackId = point.x + 10
    var pl = rackId * point.y
    pl += serial
    pl *= rackId
    let digits = pl.digits
    pl = digits[digits.count - 3]
    pl -= 5
    return pl
}

func partOne() -> String {
    let serial = Int(input)!
    var result = 0
    var resultPoint: Point = Point.init(x: 1, y: 1)
    for x in 1...300 {
        for y in 1...300 {
            let point = Point.init(x: x, y: y)
            let grid = get3x3Grid(point)
            let total = grid.map { powerLevel($0, serial) }.reduce(0, +)

            if total > result {
                result = total
                resultPoint = point
            }
        }
    }
    return "\(resultPoint.x),\(resultPoint.y)"
}

func partTwo() -> String {
    let serial = Int(input)!
    var powerLevels: [Point: Int] = [:]
    for x in 1...300 {
        for y in 1...300 {
            let point = Point.init(x: x, y: y)
            let p2 = Point.init(x: x, y: y-1)
            let p3 = Point.init(x: x-1, y: y)
            let p4 = Point.init(x: x-1, y: y-1)

            powerLevels[point] = powerLevel(point, serial) + powerLevels[p2, default: 0] + powerLevels[p3, default: 0] - powerLevels[p4, default: 0]
        }
    }

    var result = 0
    var resultPoint: Point = Point.init(x: 1, y: 1)
    var gridSize: Int = 0
    for s in 1...300 {
        for x in s...300 {
            for y in s...300 {
                let p1 = Point.init(x: x, y: y)
                let p2 = Point.init(x: x, y: y-s)
                let p3 = Point.init(x: x-s, y: y)
                let p4 = Point.init(x: x-s, y: y-s)
                let total = powerLevels[p1, default: 0] - powerLevels[p2, default: 0] - powerLevels[p3, default: 0] + powerLevels[p4,default: 0]

                if total > result {
                    result = total
                    resultPoint = p1
                    gridSize = s
                }
            }
        }


    }

    return "\(resultPoint.x - gridSize + 1),\(resultPoint.y - gridSize + 1),\(gridSize)"
}

print("Part 1 answer is \(partOne())")
print("Part 2 answer is \(partTwo())")
