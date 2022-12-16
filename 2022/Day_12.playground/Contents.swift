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
    typealias Cell = [Point: Character]

    var grid: Cell = [:]
    let rowCount: Int
    let colCount: Int
    var start: Point
    var end: Point
    var all: [Point] = []

    init(_ input: [String]) {
        self.rowCount = input.count
        self.colCount = input[0].count
        self.start = Point(x: 0, y: 0)
        self.end = Point(x: 0, y: 0)
      
        input.enumerated().forEach { (i,line) in
            line.enumerated().forEach { (j,char) in
                let p = Point.init(x: i, y: j)
                if char == "S" {
                    self.start = p
                    grid[p] = "a".first!
                }
                else if char == "E" {
                    self.end = p
                    grid[p] = "z".first!
                }
                else {
                    grid[p] = char
                }
                
                if grid[p] == "a" {
                    all.append(p)
                }
            }
        }
    }

    func debugPrint() {
        print("grid start")
        print("rc", separator: "", terminator: " ")
        (0 ..< colCount).forEach {
            print($0, separator: " ", terminator: " ")
        }
        print("\n\n")
        for r in (0 ..< rowCount) {
            print(r, separator: " ", terminator: "  ")
            for c in (0 ..< colCount) {
                let p = Point(x: r, y: c)
                print(grid[p, default: " ".first!], separator: " ", terminator: " ")
            }
            print("\n")
        }
        print("grid end")
    }
    
    func pathCountFromStart() -> Int {
        pathCount([(start,0)])
    }
    
    func pathCountFromAnyStart() -> Int {
        pathCount(all.map { ($0,0) })
    }
    
    func pathCount(_ queue: [(Point,Int)]) -> Int {
        var queue = queue
        var visited: Set<Point> = []
        var result = 0
        outer: while !queue.isEmpty {
            let f = queue.removeFirst()
            if visited.contains(f.0) {
                continue outer
            }
            
            let p = f.0
            let cur = grid[p]!
            visited.insert(p)
            if p == end {
                result = f.1
                break
            }
            
            let next = p.adjacent()
                .filter {
                    guard let c = grid[$0] else { return false }
                    let v = c.asciiValue!
                    let t = cur.asciiValue!
                    return v <= 1+t
            }
            
            for n in next {
                queue.append((n,f.1 + 1))
            }
        }
        return result
    }
}

let grid = Grid(input)

func partOne() -> CustomStringConvertible {
    grid.pathCountFromStart()
}

func partTwo() -> CustomStringConvertible {
    grid.pathCountFromAnyStart()
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
