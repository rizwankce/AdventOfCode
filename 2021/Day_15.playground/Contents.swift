import Cocoa

//let input = load(.test).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

let input = """
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581
""".components(separatedBy: .newlines)

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
    let maxX: Int
    let maxY: Int

    let start: Point
    let end: Point

    init(_ input: [String]) {
        self.maxX = input[0].count
        self.maxY = input.count

        self.start = Point.init(x: 0, y: 0)
        self.end = Point.init(x: maxX - 1, y: maxY - 1)

        input.enumerated().forEach { (i,line) in
            line.enumerated().forEach { (j,char) in
                let p = Point.init(x: i, y: j)
                grid[p] = Int(String(char))!
            }
        }

    }

    init(_ grid: [Point: Int], _ maxX: Int, _ maxY: Int) {
        self.grid = grid
        self.maxX = maxX
        self.maxY = maxY
        self.start = Point.init(x: 0, y: 0)
        self.end = Point.init(x: maxX - 1, y: maxY - 1)
    }

    func debugPrint() {
        print("grid start")
        print("rc", separator: "", terminator: " ")
        (0 ..< maxY).map {
            print($0, separator: " ", terminator: " ")
        }
        print("\n\n")
        for r in (0 ..< maxX) {
            print(r, separator: " ", terminator: "  ")
            for c in (0 ..< maxY) {
                let p = Point(x: r, y: c)
                print(grid[p]!, separator: " ", terminator: " ")
            }
            print("\n")
        }
        print("grid end")
    }

    func makeNewGrid() -> Grid {

        var newG: [Point: Int] = [:]

        for x in (0 ..< 5*maxX) {
            for y in (0 ..< 5*maxY) {
                let p = Point.init(x: x, y: y)
                let newX = x % maxX
                let newY = y % maxY
                let newP = Point.init(x: newX, y: newY)
                // to get 11,11
                // 11 % 10 = 1, 11 % 10 = 1
                // g(1,1) + 11/10 + 11/10
                // g(1,1) + 1 + 1
                var val = grid[newP]! + (x / maxX) + ( y / maxY)
                if val > 9 {
                    val -= 9
                }
                newG[p] = val
            }
        }
        return Grid.init(newG, 5*maxX, 5*maxY)
    }

    func lowestTotalRisk() -> Int {

        var allCosts: [Point: Int] = [:]
        var queue: [Point: Int] = [start: 0]

        while true {
            let pc = queue.min { q1, q2 in
                q1.value < q2.value
            }

            guard let pc = pc else { break }

            let point = pc.key
            let cost = pc.value

            queue.removeValue(forKey: point)

            let minCost = allCosts[end] != nil ? allCosts[end]! : Int.max

            if cost < minCost {
                if point.adjacent().contains(where: { $0 == end }) {
                    allCosts[end] = min(minCost, cost + grid[end]!)
                }

                let next = point.adjacent().filter { $0 != end }

                for n in next {
                    if let val = grid[n] {
                        let total = cost + val
                        if let prev = allCosts[n], prev <= total {
                            continue
                        }
                        allCosts[n] = total
                        queue[n] = total
                    }
                }
            }
        }

        return allCosts[end]!
    }
}

func partOne() -> Int {
    Grid(input).lowestTotalRisk()
}

func partTwo() -> Int {
    Grid(input).makeNewGrid().lowestTotalRisk()
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

