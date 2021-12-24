import Cocoa

let input = load(.input, runFromTerminal:true).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

print(input)

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
                if x == 0 || y == 0 {
                    points.append(Point.init(x: self.x + x, y: self.y + y))
                }
            }
        }
        points.removeAll(where: { $0 == self })
        return points
    }
}

struct Grid {
    typealias Cell = [Point: Character]

    var grid: Cell = [:]
    let rowCount: Int
    let colCount: Int

    init(_ input: [String]) {
        print(input)
        self.rowCount = input.count
        self.colCount = input[0].count
        print(rowCount,colCount)
        input.enumerated().forEach { (i,line) in
            line.enumerated().forEach { (j,char) in
                let p = Point.init(x: i, y: j)
                grid[p] = char
            }
        }
    }

    func debugPrint() {
        print("grid start")
        for r in (0 ... rowCount) {
            for c in (0 ... colCount) {
                let p = Point(x: r, y: c)
                print(grid[p, default: " "], separator: " ", terminator: " ")
            }
            print("\n")
        }
        print("grid end")
    }
}

let grid = Grid.init(input)
grid.debugPrint()

func partOne() -> Int {
    return 0
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
