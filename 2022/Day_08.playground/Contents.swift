import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

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
    typealias Cell = [Point: Int]

    var grid: Cell = [:]
    let rowCount: Int
    let colCount: Int

    init(_ input: [String]) {
        self.rowCount = input[0].count
        self.colCount = input.count

        input.enumerated().forEach { (i,line) in
            line.enumerated().forEach { (j,char) in
                let p = Point.init(x: i, y: j)
                grid[p] = Int(String(char))!
            }
        }
    }

    func debugPrint() {
        print("grid start")
        print("rc", separator: "", terminator: " ")
        (0 ..< rowCount).map {
            print($0, separator: " ", terminator: " ")
        }
        print("\n\n")
        for r in (0 ..< rowCount) {
            print(r, separator: " ", terminator: "  ")
            for c in (0 ..< colCount) {
                let p = Point(x: r, y: c)
                print(grid[p]!, separator: " ", terminator: " ")
            }
            print("\n")
        }
        print("grid end")
    }

    func isEdge(_ p: Point) -> Bool {
        p.adjacent().filter { grid.keys.contains($0) }.count != 4
    }
    
    func isVisible(_ values: [Int], _ value: Int ) -> Bool {
        values.filter { $0 < value }.count == values.count
    }
    
    func allSideVisibilityPoint(_ p: Point) -> [[Int]] {
        let r = (p.x+1 ..< rowCount).compactMap { grid[Point.init(x: $0, y: p.y)] }
        let t = (0 ..< p.x).reversed().compactMap { grid[Point.init(x: $0, y: p.y)] }
        let b = (p.y+1 ..< colCount).compactMap { grid[Point.init(x: p.x, y: $0)]}
        let l = (0 ..< p.y).reversed().compactMap {
            grid[Point.init(x: p.x, y: $0)]
        }
        return [l,r,t,b]
    }
    
    func isVisible(_ p: Point, _ v: Int) -> Bool {
        let all = allSideVisibilityPoint(p)
        return isVisible(all[0], v) || isVisible(all[1], v) || isVisible(all[2], v) || isVisible(all[3], v)
    }
    
    func visibleTrees() -> Int {
        var visible = 0
        for r in (0 ..< rowCount) {
            for c in (0 ..< colCount) {
                let p = Point(x: r, y: c)
                let v = grid[p]!
                if isEdge(p) || isVisible(p, v) {
                    visible += 1
                }
            }
        }
        return visible
    }
    
    func scenicScore(_ values: [Int], _ value: Int) -> Int {
        var count = 0
        for v in values {
            if v >= value {
                count += 1
                break
            }
            count += 1
        }
        return count
    }
    
    func scenicScore(_ p: Point, _ v: Int) -> Int {
        let all = allSideVisibilityPoint(p)
        return scenicScore(all[0], v) * scenicScore(all[1], v) * scenicScore(all[2], v) * scenicScore(all[3], v)
    }
    
    func score() -> Int {
        var allScores: [Int] = []
        for r in (0 ..< rowCount) {
            for c in (0 ..< colCount) {
                let p = Point(x: r, y: c)
                let v = grid[p]!
                if !isEdge(p) {
                    allScores.append(scenicScore(p, v))
                }
            }
        }
        return allScores.max()!
    }
}

func partOne() -> Int {
    let grid = Grid(input)
    return grid.visibleTrees()
}

func partTwo() -> Int {
    let grid = Grid(input)
    return grid.score()
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
