import Cocoa
import Darwin

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: "\n\n")

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }
}

struct Grid {
    typealias Cell = [Point: String]

    var grid: Cell = [:]
    let rowCount: Int
    let colCount: Int

    init(_ points: [Point]) {
        self.rowCount = points.map(\.x).max()!
        self.colCount = points.map(\.y).max()!

        points.forEach { p in
            grid[p] = "#"
        }
    }


    func debugPrint() {
        print("\n")
        for r in (0 ... rowCount) {
            for c in (0 ... colCount) {
                let p = Point(x: r, y: c)
                print(grid[p, default: " "], separator: " ", terminator: " ")
            }
            print("\n")
        }
    }

    func fold(_ dir: String, _ count: Int) -> Grid {
        var new: [Point] = []
        for point in grid.keys {
            let x = point.x
            let y = point.y
            if dir == "x" {
                if point.y < count {
                    new.append(point)
                }
                else {
                    new.append(Point.init(
                        x: x,
                        y: (count - (y - count))
                    ))
                }
            }

            if dir == "y" {
                if point.x < count {
                    new.append(point)
                }
                else {
                    new.append(Point.init(
                        x: count - (x - count),
                        y: y
                    ))
                }
            }
        }

        return Grid.init(new)
    }
}

var points: [Point] = []

for line in input[0].components(separatedBy: .newlines) {
    let x = Int(line.split(separator: ",")[1])!
    let y = Int(line.split(separator: ",")[0])!
    let p = Point.init(x: x, y: y)
    points.append(p)
}

var folds: [(String, Int)] = []

for line in input[1].components(separatedBy: .newlines) {
    let f = line.split(separator: " ")[2]
    let xy = f.split(separator: "=")
    folds.append((String(xy[0]), Int(xy[1])!))
}

var grid = Grid.init(points)

func partOne() -> Int {
    var g = Grid.init(points)
    for fold in folds {
        let newG = g.fold(fold.0, fold.1)
        g = newG
        break
    }

    return g.grid.filter { $0.value == "#" }.count
}

func partTwo() -> Int {
    var g = Grid.init(points)

    for fold in folds {
        let newG = g.fold(fold.0, fold.1)
        g = newG
    }

    g.debugPrint()
    return 0
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

