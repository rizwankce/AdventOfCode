import Cocoa

let input = load(.input, runFromTerminal:true).trimmingCharacters(in: .newlines).components(separatedBy: "\n\n")

//print(input)

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int
    
    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }
    
    func move(direction: Direction, from dir: Direction) -> Point {
        switch direction {
        case .left: return dir == .left ? Point(x: x-1, y: y) :     Point(x: x+1, y: y)
        case .right: return dir == .right ? Point(x: x, y: y+1) : Point(x: x, y: y-1)
        }
    }
}

enum Direction: String {
    case left = "L"
    case right = "R"
}

enum Facing: Int {
    case left = 2
    case right = 0
    case up = 3
    case down = 1
    
    func move(_ direction: Direction) -> Facing {
        switch self {
        case .left: return direction == Direction.left ? .down : .up
        case .right: return direction == Direction.left ? .down : .up
        case .up: return direction == Direction.left ? .right : .left
        case .down: return direction == Direction.left ? .right : .left
        }
    }
}
struct Grid {
    typealias Cell = [Point: String]

    var grid: Cell = [:]
    var rowCount: Int = 0
    var colCount: Int = 0
    var start: Point = Point(x: 0, y: 0)

    init(_ input: [String]) {
//        print(input)
        var maxX = 0
        var maxY = 0
        var s: Point?
        input.enumerated().forEach { (i,line) in
            line.enumerated().forEach { (j,char) in
                maxX = max(maxX, i)
                maxY = max(maxY, j)
                let p = Point.init(x: i, y: j)
                if s == nil && [".","#"].contains(char) {
                    s = p
                }
                grid[p] = String(char)
            }
        }
        
        self.rowCount = maxX
        self.colCount = maxY
        self.start = Point(x: s!.x, y: s!.y-1)
        print(self.start)
        print(rowCount)
        print(colCount)
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
                print(grid[p, default: " "], separator: " ", terminator: " ")
            }
            print("\n")
        }
        print("grid end")
    }
    
    func password(_ directions: [(Direction, Int)]) -> Int {
        var curP = start
        var curD: Direction = .right
        var curF: Facing = .right
        for direction in directions {
//            print(direction)
            let dir = direction.0
            
            for _ in 1 ... direction.1 {
                var new = curP.move(direction: dir, from: curD)
                if grid[new] == "#" {
                    break
                }
                
                if grid[new] == nil || grid[new] == " "{
                    while grid[new] != "." && grid[new] != "#" {
                        new = new.move(direction: dir, from: curD)
                        if new.x == curP.x {
                            new.y = new.y % colCount
                        }
                        else if new.y == curP.y {
                            new.x = new.x % rowCount
                        }
                    }
                    print(new,new.y,colCount, new.y % colCount)
                }
                curP = new
            }
            curF = curF.move(dir)
//            print(curF.rawValue)
        }

        let d = curF.rawValue
//        print(d)
        return (1000 * (curP.x+1)) + (4 * (curP.y+1)) + curF.rawValue
    }
}

let grid = Grid(input[0].components(separatedBy: .newlines))
//grid.debugPrint()
var directions: [(Direction,Int)] = []

var amount = ""
for line in input[1] {
    var line = String(line)
    if ["R","L"].contains(line) {
        let dir = Direction(rawValue: line)!
        let v = Int(amount)!
        amount = ""
        directions.append((dir,v))
    }
    else {
        amount += line
    }
}
func partOne() -> CustomStringConvertible {
    return grid.password(directions)
}

func partTwo() -> CustomStringConvertible {
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
