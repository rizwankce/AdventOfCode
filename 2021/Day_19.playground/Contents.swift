import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: "\n\n")

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int
    var z: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y) Z:\(self.z))"
        }
    }

    init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }

    init(_ line: String) {
        let coordinates = line.components(separatedBy: ",").map { Int($0)! }
        self.x = coordinates[0]
        self.y = coordinates[1]
        self.z = coordinates[2]
    }

    func sum() -> Int {
        x+y+z
    }
}

func difference(_ p1: Point, _ p2: Point) -> Point {
    return Point.init(x: p1.x - p2.x, y: p1.y - p2.y, z: p1.z - p2.z)
}

func add(_ p1: Point, _ p2: Point) -> Point {
    return Point.init(x: p1.x + p2.x, y: p1.y + p2.y, z: p1.z + p2.z)
}

func multiply(_ p1: Point, _ p2: Point) -> Point {
    return Point.init(x: p1.x * p2.x, y: p1.y * p2.y, z: p1.z * p2.z)
}

let rotations = [
    [Point.init("-1,0,0"),Point.init("0,-1,0"),Point.init("0,0,1")],
    [Point.init("-1,0,0"),Point.init("0,0,-1"),Point.init("0,-1,0")],
    [Point.init("-1,0,0"),Point.init("0,0,1"),Point.init("0,1,0")],
    [Point.init("-1,0,0"),Point.init("0,1,0"),Point.init("0,0,-1")],

    [Point.init("0,-1,0"),Point.init("-1,0,0"),Point.init("0,0,-1")],
    [Point.init("0,-1,0"),Point.init("0,0,-1"),Point.init("1,0,0")],
    [Point.init("0,-1,0"),Point.init("0,0,1"),Point.init("-1,0,0")],
    [Point.init("0,-1,0"),Point.init("1,0,0"),Point.init("0,0,1")],

    [Point.init("0,0,-1"),Point.init("-1,0,0"),Point.init("0,1,0")],
    [Point.init("0,0,-1"),Point.init("0,-1,0"),Point.init("-1,0,0")],
    [Point.init("0,0,-1"),Point.init("0,1,0"),Point.init("1,0,0")],
    [Point.init("0,0,-1"),Point.init("1,0,0"),Point.init("0,-1,0")],

    [Point.init("0,0,1"),Point.init("-1,0,0"),Point.init("0,-1,0")],
    [Point.init("0,0,1"),Point.init("0,-1,0"),Point.init("1,0,0")],
    [Point.init("0,0,1"),Point.init("0,1,0"),Point.init("-1,0,0")],
    [Point.init("0,0,1"),Point.init("1,0,0"),Point.init("0,1,0")],

    [Point.init("0,1,0"),Point.init("-1,0,0"),Point.init("0,0,1")],
    [Point.init("0,1,0"),Point.init("0,0,-1"),Point.init("-1,0,0")],
    [Point.init("0,1,0"),Point.init("0,0,1"),Point.init("1,0,0")],
    [Point.init("0,1,0"),Point.init("1,0,0"),Point.init("0,0,-1")],

    [Point.init("1,0,0"),Point.init("0,-1,0"),Point.init("0,0,-1")],
    [Point.init("1,0,0"),Point.init("0,0,-1"),Point.init("0,1,0")],
    [Point.init("1,0,0"),Point.init("0,0,1"),Point.init("0,-1,0")],
    [Point.init("1,0,0"),Point.init("0,1,0"),Point.init("0,0,1")],
]

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}

class Scanner: CustomStringConvertible {
    var number: Int = 0
    var points: Set<Point> = []

    var description: String {
        points.map { $0.description }.joined()
    }

    init(_ number: Int, _ points: Set<Point>) {
        self.number = number
        self.points = points
    }

    func rotated() -> [Scanner] {
        var result: [Scanner] = []

        for rot in rotations {
            let xrot = rot[0]
            let yrot = rot[1]
            let zrot = rot[2]

            var new: Set<Point> = []

            for p in points {
                let nx = multiply(p, xrot).sum()
                let ny = multiply(p, yrot).sum()
                let nz = multiply(p, zrot).sum()
                new.insert(Point.init(x: nx, y: ny, z: nz))
            }
            let scanner = Scanner(number, new)
            result.append(scanner)
        }
        return result
    }
}

var scanners: [Scanner] = []

for (i,grid) in input.enumerated() {
    var points: Set<Point> = []
    for line in grid.components(separatedBy: .newlines) {
        if line.contains("---") { continue }
        points.insert(Point.init(line))
    }
    let scanner = Scanner.init(i, points)
    scanners.append(scanner)
}

var rotated: [Int: [Scanner]] = [:]

for scanner in scanners {
    rotated[scanner.number] = scanner.rotated()
}

var known: Scanner = scanners[0]
scanners = Array(scanners.dropFirst())

var scannersPoint: [Point] = []

while !scanners.isEmpty {
    print("Left Scanners to process: \(scanners.count)")
    outerloop: for s in scanners {
        //print("Checking Scanner: \(s.number)")
        let rot = rotated[s.number, default: []]
        for o in rot {
            let test_points = o.points
            for p1 in known.points {
                for (j,p2) in o.points.enumerated() {
                    if j+11 >= test_points.count {
                        break
                    }

                    let pointDiff = difference(p1,p2)
                    var matches = 1
                    for p3 in test_points {
                        let c2 = add(p3,pointDiff)
                        if known.points.contains(c2) {
                            matches += 1
                        }
                    }

                    if matches >= 12 {
                        var new: Set<Point> = []
                        o.points.forEach {
                            new.insert(add($0, pointDiff))
                        }

                        o.points = new

                        scanners.removeAll(where: {
                            $0.number == s.number
                        })

                        known.points = known.points.union(new)
                        scannersPoint.append(pointDiff)
                        break outerloop
                    }
                }
            }
        }
    }
}

func partOne() -> Int {
    return known.points.count
}

func partTwo() -> Int {
    var maxDistance = 0
    for p1 in scannersPoint {
        for p2 in scannersPoint {
            let dist = abs(p1.x - p2.x) + abs(p1.y - p2.y) + abs(p1.z - p2.z)
            maxDistance = max(dist, maxDistance)
        }
    }
    return maxDistance
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

