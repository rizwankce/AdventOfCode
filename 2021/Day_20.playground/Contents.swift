import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: "\n\n")

extension Array where Element == Int {
    var intValue: Int {
        var value = 0
        for element in self {
            value *= 2
            value += element
        }
        return value
    }
}


struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }

    func adjacent() -> [Point] {
        var points: [Point] = []
        for x in [-1,0,1] {
            for y in [-1,0,1] {
                points.append(Point.init(x: self.x + x, y: self.y + y))
            }
        }
        return points
    }
}

struct Grid {
    typealias Cell = [Point: String]

    var grid: Cell = [:]

    init(_ input: [String]) {
        input.enumerated().forEach { (i,line) in
            line.enumerated().forEach { (j,char) in
                let p = Point.init(x: i, y: j)
                if char == "#" {
                    grid[p] = String(char)
                }
            }
        }
    }

    init(_ new: [Point: String]) {
        self.grid = new
    }

    func enhance(_ on: Bool) -> Grid {
        var new: [Point: String] = [:]
        let xs = grid.keys.map { $0.x }
        let ys = grid.keys.map { $0.y }
        let maxX = xs.max()!
        let maxY = ys.max()!
        let minX = xs.min()!
        let minY = ys.min()!

        for x in (minX-1 ... maxX+1) {
            for y in (minY-1 ... maxY+1) {
                let point = Point.init(x: x, y: y)
                let pixels = point.adjacent().map { grid[$0] ?? (on ? "#" : ".") }
                let value = pixels.map { p -> Int in
                    if p == "." {
                        return 0
                    }
                    else if p == "#" {
                        return 1
                    }
                    fatalError()
                }
                assert(value.count == 9)
                let next = algo[value.intValue]
                new[point] = String(next)
            }
        }
        return Grid.init(new)
    }
}

let algo = input[0].map { $0 }

func takeStep(_ count: Int) -> Int {
    var cur = Grid.init(input[1].components(separatedBy: .newlines))
    var result = 0

    for step in 1...count {
        cur = cur.enhance(step%2==0)
        result = cur.grid.values.filter { $0 == "#" }.count
    }
    return result
}

func partOne() -> Int {
    takeStep(2)
}

func partTwo() -> Int {
    takeStep(50)
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

