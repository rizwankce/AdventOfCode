import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int
    var z: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y) Z: \(self.z)"
        }
    }

    init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(_ line: String) {
        let com = line.components(separatedBy: ",").compactMap(Int.init)
        self.x = com[0]
        self.y = com[1]
        self.z = com[2]
    }
    
    func neighbors() -> [Point] {
        [
            Point(x: x-1, y: y, z: z),
            Point(x: x+1, y: y, z: z),
            Point(x: x, y: y-1, z: z),
            Point(x: x, y: y+1, z: z),
            Point(x: x, y: y, z: z-1),
            Point(x: x, y: y, z: z+1)
        ]
    }
    
    func inRange(_ xr: Range<Int>, _ yr: Range<Int>, _ zr: Range<Int>) -> Bool {
        xr.contains(x) && yr.contains(y) && zr.contains(z)
    }
}

func range(_ keyPath: KeyPath<Point,Int>) -> Range<Int> {
    var low = 0
    var high = 0
    for p in points {
        if p[keyPath: keyPath] < low {
            low = p[keyPath: keyPath]
        }
        if high < p[keyPath: keyPath] {
            high = p[keyPath: keyPath
            ]
        }
    }
    return Range.init(uncheckedBounds: (lower: low - 2, upper: high + 2))
}

let points = Set(input.map(Point.init))
let xr = range(\Point.x)
let yr = range(\Point.y)
let zr = range(\Point.z)

func surfaceArea(_ p: Point) -> Int {
    let c = p.neighbors().filter { points.contains($0) }.count
    return 6 - c
}

func partOne() -> CustomStringConvertible {
    return points.map { surfaceArea($0) }.reduce(0, +)
}

func partTwo() -> CustomStringConvertible {
    var out: Set<Point> = []
    var queue: [Point] = [Point(x: 0, y: 0, z: 0)]
    
    while !queue.isEmpty {
        let p = queue.removeFirst()
        
        guard p.inRange(xr, yr, zr) else { continue }
        
        p.neighbors().filter { !points.contains($0) && !out.contains($0) }
            .forEach {
                queue.append($0)
                out.insert($0)
            }
        
        if out.count > 100_000 { // outside size may be huge. so adding a stop - trail and error here
            break
        }
    }
    
    return points.flatMap { $0.neighbors() }.filter { out.contains($0) }.count
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
