import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }
    
    func down() -> Point {
        Point(x: x, y: y+1)
    }
    
    func downLeft() -> Point {
        Point(x: x-1, y: y+1)
    }
    
    func downRight() -> Point {
        Point(x: x+1, y: y+1)
    }
    
    func bottom3() -> [Point] {
        [down(),downLeft(),downRight()]
    }
}

var lines: [[Point]] = []

for line in input {
    let com = line.components(separatedBy: " -> ")
    var points: [Point] = []
    for c in com {
        let ps = c.components(separatedBy: ",").compactMap { Int($0) }
        points.append(Point(x: ps[0], y: ps[1]))
    }
    lines.append(points)
}

var rocks: Set<Point> = []
var lastRockY: Int = 0
for line in lines {
    for pair in zip(line,line.dropFirst()) {
        let maxX = max(pair.0.x,pair.1.x)
        let minX = min(pair.0.x,pair.1.x)
        let maxY = max(pair.0.y,pair.1.y)
        let minY = min(pair.0.y,pair.1.y)
        
        if maxY > lastRockY {
            lastRockY = maxY
        }
        
        (minX...maxX).map { x in
            (minY...maxY).map { y in
                rocks.insert(Point(x: x, y: y))
            }
        }
    }
}

func dropSand(_ blocked: Set<Point>, _ limit: Int, _ voidArea: Bool) -> Int {
    var blocked = blocked
    let start = Point(x: 500, y: 0)
    var sand = start
    var count = 0
    
    while true {
        if !blocked.contains(sand.down()) {
            sand = sand.down()
        }
        else if !blocked.contains(sand.downLeft()) {
            sand = sand.downLeft()
        }
        else if !blocked.contains(sand.downRight()) {
            sand = sand.downRight()
        }
        else {
            blocked.insert(sand)
            count += 1
            if sand == start {
                break
            }
            sand = start
        }
        
        if voidArea && sand.y > limit {
            break
        }
    }
    
    return count
}

func partOne() -> CustomStringConvertible {
    return dropSand(rocks,lastRockY + 1, true)
}

func partTwo() -> CustomStringConvertible {
    (-10_000 ... 10_000).forEach {
        rocks.insert(Point(x: $0, y: lastRockY + 2))
    }
    
    return dropSand(rocks,lastRockY + 2, true)
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
