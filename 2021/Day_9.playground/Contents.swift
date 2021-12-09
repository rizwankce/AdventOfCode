import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

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
            Point.init(x: x, y: y+1)
        ]
    }
}

var grid: [Point: Int] = [:]
var maxX: Int = input.count
var maxY: Int = input[0].count

input.enumerated().forEach { (i,line) in
    line.enumerated().forEach { (j,char) in
        let p = Point.init(x: i, y: j)
        grid[p] = Int(String(char))!
    }
}

func printGrid(_ grid: [Point: Int]) {
    print("grid start")
    for x in (0..<maxX) {
        for y in (0..<maxY) {
            let p = Point.init(x: x, y: y)
            print(grid[p]!, separator: " ", terminator: "")
        }
        print("\n")
    }
    print("grid end")
}

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


func lowPoints() -> [Point] {
    var low: [Point] = []

    for p in grid.keys {
        let cur = grid[p]!
        let ad = p.adjacent().map { cur < grid[$0, default: 10] }

        if ad.reduce(true, { result, next in
            result && next
        }) {
            low.append(p)
        }
    }

    return low
}

func partOne() -> Int {
    lowPoints()
        .map { grid[$0]! }
        .map { $0 + 1 }
        .reduce(0, +)
}

func partTwo() -> Int {

    func basin(_ p: [Point], _ visited: [Point]) -> Int {
        var visited = visited
        visited.append(contentsOf: p)

        let ad = p.map {
            $0.adjacent().filter { !visited.contains($0) }
        }.joined()
        let new = Array(ad).uniques

        let next = new.filter { point in
            grid[point, default: 9] != 9
        }

        if next.count > 0 {
            visited.append(contentsOf: next)
            return next.count + basin(next, visited)
        }
        else {
            return 1
        }
    }

    var size: [Int] = []

    for p in lowPoints() {
        let bSize = basin([p], [])
        size.append(bSize)
    }

    size = size.sorted().reversed()

    return size[0 ..< 3].reduce(1, *)
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



