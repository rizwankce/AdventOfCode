import Cocoa
import Darwin

let input = load(.test, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

print(input)

enum Direction: Character {
    case east = ">"
    case south = "v"
}

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }

    func adjacent(_ direction: Direction, _ rowCount: Int, _ colCount: Int) -> Point {
        switch direction {
        case .east:
            if y+1 >= colCount {
                return Point.init(x: self.x , y: colCount - (self.y+1))
            }
            return Point.init(x: self.x, y: self.y+1)
        case .south:
            if x+1 >= rowCount {
                return Point.init(x: rowCount - (self.x+1), y: self.y)
            }
            return Point.init(x: self.x+1, y: self.y)
        }
    }
}

struct Grid {
    typealias Cell = [Point: Character]

    var grid: Cell = [:]
    let rowCount: Int
    let colCount: Int

    init(_ input: [String]) {
        self.rowCount = input.count
        self.colCount = input[0].count

        input.enumerated().forEach { (i,line) in
            line.enumerated().forEach { (j,char) in
                let p = Point.init(x: i, y: j)
                grid[p] = char
            }
        }

        print(rowCount)
        print(colCount)
    }

    init(_ points: Cell, _ rowCount: Int, _ colCount: Int) {
        self.grid = points
        self.rowCount = rowCount
        self.colCount = colCount
    }

    func debugPrint() {
        print("grid start")
        print("rc", separator: "", terminator: " ")
        (0 ..< colCount).map {
            print($0, separator: " ", terminator: " ")
        }
        print("\n\n")
        for r in (0 ..< rowCount) {
            print(r, separator: " ", terminator: "  ")
            for c in (0 ..< colCount) {
                let p = Point(x: r, y: c)
                print(grid[p, default: "."], separator: " ", terminator: " ")
            }
            print("\n")
        }
        print("grid end")
    }

    mutating func step() -> Bool {
        let copy = grid
        var new: [Point: Character] = [:]
        let easters = grid.filter { $0.value == ">"}.keys
        easters.forEach { p in
            let next = p.adjacent(.east, rowCount, colCount)
            if grid[next] == "." {
                new[next] = grid[p]
                new[p] = "."
            }
            else {
                new[p] = grid[p]
            }
        }

        for n in new {
            grid[n.key] = n.value
        }

        new = [:]
        let southers = grid.filter { $0.value == "v"}.keys
        southers.forEach { p in
            let next = p.adjacent(.south, rowCount,colCount)
            if grid[next] == "." {
                new[next] = grid[p]
                new[p] = "."
            }
        }

        for n in new {
            grid[n.key] = n.value
        }

        return copy == grid
    }
}

func partOne() -> Int {
    var grid = Grid.init(input)
    var result = 0
    for step in 1... {
        if grid.step() {
            result = step
            break
        }
    }

    return result
}

func partTwo() -> Int {
    return 0
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

enum PuzzleInput: String {
    case input = "input"
    case test  = "test_input"
}

func load(_ input: PuzzleInput, runFromTerminal: Bool = false) -> String {
    switch input {
    case .input:
        return load(file: "input", runFromTerminal)
    default:
        return load(file: "test_input", runFromTerminal)
    }
}

func load(file name: String, _ runFromTerminal: Bool = false) -> String {

    if runFromTerminal {
        let projectURL = URL(fileURLWithPath: #file)
                .deletingLastPathComponent()
                .appendingPathComponent("Resources")
        let fileURL = projectURL.appendingPathComponent(name+".txt")
        guard let content = try? String(contentsOf: fileURL, encoding: .utf8) else {
            fatalError("Cannot convert file contents to string for file :\(name)")
        }

        return content
    }

    guard let url = Bundle.main.url(forResource: name, withExtension: "txt") else {
        fatalError("Cannot load file with name :\(name)")
    }

    guard let content = try? String(contentsOf: url, encoding: .utf8) else {
        fatalError("Cannot convert file contents to string for file :\(name)")
    }

    return content
}
