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

    func adjacent() -> [Point] {
        return [
            Point.init(x: x-1, y: y),
            Point.init(x: x+1, y: y),
            Point.init(x: x, y: y-1),
            Point.init(x: x, y: y+1),
            Point.init(x: x-1, y: y-1),
            Point.init(x: x+1, y: y+1),
            Point.init(x: x+1, y: y-1),
            Point.init(x: x-1, y: y+1)
        ]
    }
}

var maxX: Int = input.count
var maxY: Int = input[0].count
print("max x : \(maxY)")
print("max y : \(maxY)")

func printGrid(_ grid: [Point: Int]) {
    print("grid start")
    for x in (0..<maxX) {
        for y in (0..<maxY) {
            let p = Point.init(x: x, y: y)
            print(grid[p]!, separator: " ", terminator: " ")
        }
        print("\n")
    }
    print("grid end")
}

var grid: [Point: Int] = [:]

func makeGrid() {
    input.enumerated().forEach { (i,line) in
        line.enumerated().forEach { (j,char) in
            let p = Point.init(x: i, y: j)
            grid[p] = Int(String(char))!
        }
    }
}

func makeStep() -> Int {
    var scan: [Point] = []

    for kv in grid {
        let v = kv.key.adjacent().map { grid[$0] }
        if v.count == 8 && v.allSatisfy({
            $0 == 9
        }) {
            scan.append(kv.key)
        }
    }


    for kv in grid {
        if !scan.contains(kv.key) {
            grid[kv.key]! += 1

            if grid[kv.key]! > 9 {
                scan.append(kv.key)
            }
        }
    }

    var index = 0
    while (0 ..< scan.count).contains(index) {
        let point = scan[index]
        for p in point.adjacent() {
            if !scan.contains(p) && grid[p] != nil {
                grid[p]! += 1
                if grid[p]! > 9 {
                    scan.append(p)
                }
            }
        }
        index += 1
    }

    for p in scan {
        grid[p]! = 0
    }

    return scan.count
}

func partOne() -> Int {
    makeGrid()
    return (0 ..< 100).map { _ in makeStep() }.reduce(0, +)
}

func partTwo() -> Int {
    makeGrid()
    var step = 0
    while true {
        step += 1
        if makeStep() == 100 {
            break
        }
    }

    return step
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

