import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

enum Direction: String {
    case up = "U"
    case down = "D"
    case left = "L"
    case right = "R"
}

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }

    func neighbours() -> [Point] {
        var points: [Point] = []
        for x in [-1,0,1] {
            for y in [-1,0,1] {
                points.append(Point.init(x: self.x + x, y: self.y + y))
            }
        }
        points.removeAll(where: { $0 == self })
        return points
    }
    
    func move(_ direction: Direction) -> Point {
        switch direction {
            case .up: return Point(x: x, y: y+1)
            case .down: return Point(x: x, y: y-1)
            case .left: return Point(x: x-1, y: y)
            case .right: return Point(x: x+1, y: y)
        }
    }
}

func partOne() -> CustomStringConvertible {
    let start = Point.init(x: 0, y: 0)
    var head = start
    var tail = start
    var tailMoves: Set<Point> = [start]
    
    func isTailNearByHead() -> Bool {
        head == tail || head.neighbours().contains(tail)
    }

    func moveTail() {
        if head.x == tail.x { // same col
            tail = Point(x: tail.x, y: tail.y + (head.y > tail.y ? 1 : -1))
        }
        else if head.y == tail.y { // same row
            tail = Point(x: tail.x + (head.x > tail.x ? 1 : -1), y: tail.y)
        }
        else { // digonal
            if head.x > tail.x && head.y > tail.y { // +x,+y
                tail = Point(x: tail.x+1, y: tail.y+1)
            }
            else if head.x < tail.x && head.y < tail.y { // -x,-y
                tail = Point(x: tail.x-1, y: tail.y-1)
            }
            else if head.x > tail.x && head.y < tail.y { // +x,-y
                tail = Point(x: tail.x+1, y: tail.y-1)
            }
            else if head.x < tail.x && head.y > tail.y { // -x,+y
                tail = Point(x: tail.x-1, y: tail.y+1)
            }
            else {
                fatalError("unknwon condition")
            }
        }
        tailMoves.insert(tail)
    }

    func move(_ direction: Direction, _ steps: Int) {
        for _ in 1 ... steps {
            head = head.move(direction)
            if !isTailNearByHead() {
                moveTail()
            }
        }
    }

    for line in input {
        let com = line.components(separatedBy: " ")
        let direction = com[0]
        let stepsToMove = Int(com[1])!
        move(Direction.init(rawValue: direction)!, stepsToMove)
    }

    return tailMoves.count
}

func partTwo() -> CustomStringConvertible {
    func printGrid(_ grid: [Int: Point]) {
        let count = 10
        let g = (0...9).compactMap { grid[$0] }
        print("grid start")
        print("rc", separator: "", terminator: " ")
        (0 ..< count).map {
            print($0, separator: " ", terminator: " ")
        }
        print("\n\n")
        for c in (0 ..< count) {
            print(c, separator: " ", terminator: "  ")
            for r in (0 ..< count) {
                let p = Point(x: r, y: c)
                print(grid.values.contains(p) ? g.firstIndex(of: p)! : ".", separator: " ", terminator: " ")
            }
            print("\n")
        }
        print("grid end")
    }
    
    let start = Point.init(x: 0, y: 0)
    let head = 0
    let tail = 9
    var tailMoves: Set<Point> = [start]
    var grid: [Int: Point] = (0...9).reduce([0:start]) { partialResult, p in
        var part = partialResult
        part[p] = start
        return part
    }
    
    func isTailNearByHead(_ i: Int) -> Bool {
        let h = grid[i-1]!
        let knot = grid[i]!
        return h == knot || h.neighbours().contains(knot)
    }

    func moveTail(_ i: Int) {
        let h = grid[i-1]!
        var knot = grid[i]!
        if h.x == knot.x { // same col
            knot = Point(x: knot.x, y: knot.y + (h.y > knot.y ? 1 : -1))
        }
        else if h.y == knot.y { // same row
            knot = Point(x: knot.x + (h.x > knot.x ? 1 : -1), y: knot.y)
        }
        else { // digonal
            if h.x > knot.x && h.y > knot.y { // +x,+y
                knot = Point(x: knot.x+1, y: knot.y+1)
            }
            else if h.x < knot.x && h.y < knot.y { // -x,-y
                knot = Point(x: knot.x-1, y: knot.y-1)
            }
            else if h.x > knot.x && h.y < knot.y { // +x,-y
                knot = Point(x: knot.x+1, y: knot.y-1)
            }
            else if h.x < knot.x && h.y > knot.y { // -x,+y
                knot = Point(x: knot.x-1, y: knot.y+1)
            }
            else {
                fatalError("unknwon condition")
            }
        }
        grid[i] = knot
        if i == 9 {
            tailMoves.insert(knot)
        }
    }

    func move(_ direction: Direction, _ steps: Int) {
        for _ in 1 ... steps {
            grid[head] = grid[head]?.move(direction)
            
            for i in head+1 ... tail {
                if !isTailNearByHead(i) {
                    moveTail(i)
                }
            }
//            printGrid(grid)
        }
    }

    for line in input {
        let com = line.components(separatedBy: " ")
        let direction = com[0]
        let stepsToMove = Int(com[1])!
        move(Direction(rawValue: direction)!, stepsToMove)
    }

    return tailMoves.count
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
