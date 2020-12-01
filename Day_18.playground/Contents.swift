import Cocoa

let input = """
########################
#...............b.C.D.f#
#.######################
#.....@.a.B.c.d.A.e.F.g#
########################
""".components(separatedBy: .newlines).map { $0.map { String($0)}}

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}

enum Direction: Int, CaseIterable {
    case north  = 1
    case south  = 2
    case west = 3
    case east = 4

    func next() -> Self {
        switch self {
        case .north:
            return .south
        case .south :
            return .west
        case .west:
            return .east
        case .east:
            return .north
        }
    }
}

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y)"
        }
    }

    func move(_ direction: Direction) -> Point {
        switch direction {
        case .north:
            return Point.init(x: x, y: y + 1)
        case .south:
            return Point.init(x: x, y: y - 1)
        case .west:
            return Point.init(x: x - 1, y: y)
        case .east:
            return Point.init(x: x + 1, y: y)
        }
    }

    func distance() -> Int {
        return abs(x) + abs(y)
    }
}
var grid: [Point: String] = [:]
var entranceP: Point = Point.init(x: 0, y: 0)
var keys: Array<String> = []
for i in 0 ..< input.count {
    for j in 0 ..< input[i].count {
        let current = input[i][j]
        grid[Point.init(x: i, y: j)] = current
        if current == "@" {
            entranceP = Point.init(x: i, y: j)
        }
        else if current != "#" && current != "." {
            keys.append(current.lowercased())
        }
    }
}

func stepTo(_ key: String, _ p: Point, _ s: Int) -> (Int,Point) {
    var queue: Array<(steps:Int,point:Point)> = Array<(steps:Int,point:Point)>()
    queue.insert((steps:0,point:p), at: 0)
    var seen: Set<Point> = Set<Point>()
    var stepCount = s
    var nextP: Point = Point.init(x: 0, y: 0)
    while !queue.isEmpty {
        let tuple = queue.removeLast()
        let steps = tuple.steps
        let point = tuple.point
        seen.insert(point)

        Direction.allCases.forEach { (direction) in
            let pos = point.move(direction)
            if !seen.contains(pos) {
                let status = grid[pos, default: "#"]
                if status != "#" {
                    queue.insert((steps:steps+1,point:pos), at:0)
                }
                if status == key {
                    print("P: \(pos) k: \(key)")
                    stepCount = steps + 1
                    nextP = pos
                }
            }
        }
    }
    return (stepCount,nextP)
}

stepTo("a", entranceP, 0)
keys = keys.sorted().uniques
print(keys)
var count: Int = 0
var index = 0
var currentPoint = entranceP
while index < keys.count {
    let tuple = stepTo(keys[index], currentPoint, count)
    count += tuple.0
    currentPoint = tuple.1
    index += 1
    print("c: \(count)")
}
print(count)
