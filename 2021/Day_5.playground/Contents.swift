import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y)"
        }
    }
}

extension Point {
    func isSameRow(_ p: Point) -> Bool {
        self.x == p.x
    }

    func isSameCol(_ p: Point) -> Bool {
        self.y == p.y
    }

    func isSameRowOrCol(_ p: Point) -> Bool {
        isSameRow(p) || isSameCol(p)
    }

    func isDiagonal(_ p: Point) -> Bool {
        self.x + self.y
        == p.x + p.y || max(self.x, self.y) - min(self.x, self.y) == max(p.x, p.y) - min(p.x, p.y)
    }
}

func getRow(_ p1: Point, _ p2: Point) -> [Point] {
    let s = min(p1.y, p2.y)
    let e = max(p1.y, p2.y)
    return (s ... e).map { Point.init(x: p1.x, y: $0) }
}

func getCol(_ p1: Point, _ p2: Point) -> [Point] {
    let s = min(p1.x, p2.x)
    let e = max(p1.x, p2.x)
    return (s ... e).map { Point.init(x: $0, y: p1.y)}
}

func getDiagonal(_ p1: Point,_ p2: Point) -> [Point] {
    let diff = abs(p1.x - p2.x)
    let dx = p2.x > p1.x
    let dy = p2.y > p1.y
    return (0 ... diff).map { d in
        Point.init(
            x: p1.x + (dx ? d : -d),
            y: p1.y + (dy ? d : -d)
        )
    }
}

var maxX = 0
var maxY = 0

var paths = input.map { inp -> [Point] in
    let p = inp.components(separatedBy: " -> ")
    let line = p.map { p -> Point in
        let p1 = p.components(separatedBy: ",")
        let y = Int(p1[0])!
        let x = Int(p1[1])!
        if x > maxX {
            maxX = x + 1
        }
        if y > maxY {
            maxY = y + 1
        }
        return Point(x: x, y: y)
    }
    return line
}

func printGrid(_ grid: [Point: Int]) {
    print("grid start")
    for x in (0..<maxX) {
        for y in (0..<maxY) {
            let p = Point.init(x: x, y: y)
            print(grid[p]!, separator: " ", terminator: "")
        }
        print("\n")
    }
    print("grid end")
}

func getDefaultGrid() -> [Point: Int] {
    var grid: [Point: Int] = [:]

    for x in 0 ... (maxX + 1)  {
        for y in 0 ... (maxY + 1) {
            grid[Point.init(x: x, y: y)] = 0
        }
    }

    return grid
}

//printGrid(grid)

func partOne() -> Int {
    var grid: [Point: Int] = [:]
    let given = paths.filter { $0[0].isSameRowOrCol($0[1]) }

    for g in given {
        let l1 = g[0]
        let l2 = g[1]

        if l1.isSameRow(l2) {
            getRow(l1, l2).forEach {
                grid[$0, default: 0] += 1
            }
        }
        if l1.isSameCol(l2) {
            getCol(l1, l2).forEach {
                grid[$0, default: 0] += 1
            }
        }
    }

    var result = 0

    grid.keys.forEach { p in
        if grid[p]! >= 2 {
            result += 1
        }
    }
    return result
}

func partTwo() -> Int {
    var grid: [Point: Int] = [:]
    let given = paths

    for g in given {
        let l1 = g[0]
        let l2 = g[1]

        if l1.isSameRow(l2) {
            getRow(l1, l2).forEach {
                grid[$0, default: 0] += 1
            }
        }
        else if l1.isSameCol(l2) {
            getCol(l1, l2).forEach {
                grid[$0, default: 0] += 1
            }
        }
        else if l1.isDiagonal(l2) {
            getDiagonal(l1, l2).forEach {
                grid[$0, default: 0] += 1
            }
        }
    }

    var result = 0

    grid.keys.forEach { p in
        if grid[p]! >= 2 {
            result += 1
        }
    }
    return result
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

enum PuzzleInput: String {
    case input = "input"
    case test  = "test_input"
}

func load(_ input: PuzzleInput) -> String {
    switch input {
    case .input:
        return load(file: "input")
    default:
        return load(file: "test_input")
    }
}

func load(file name: String) -> String {
    guard let url = Bundle.main.url(forResource: name, withExtension: "txt") else {
        fatalError("Cannot load file with name :\(name)")
    }

    guard let content = try? String(contentsOf: url, encoding: .utf8) else {
        fatalError("Cannot convert file contents to string for file :\(name)")
    }

    return content
}

