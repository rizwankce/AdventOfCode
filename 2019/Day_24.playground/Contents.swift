import Cocoa

var input = """
####.
.###.
.#..#
##.##
###..
""".components(separatedBy: "\n").map { $0.map { String($0) }}

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y)"
        }
    }

    var up: Self { .init(x: x, y: y - 1) }
    var down: Self { .init(x: x, y: y + 1) }
    var left: Self { .init(x: x - 1, y: y) }
    var right: Self { .init(x: x + 1, y: y) }

    var neighbours: [Self] { [up, left, right, down] }
}

var grid: [Point: String] = [:]
for i in 0..<input.count {
    for j in 0..<input[i].count {
        grid[Point.init(x: i, y: j)] = input[i][j]
    }
}

func tick(_ grid: [Point: String]) -> [Point: String] {
    var next: [Point: String] = [:]

    for point in grid.keys {
        let value = grid[point]
        var found = false
        var count = 0
        point.neighbours.forEach { (p) in
            if let tile = grid[p] {
                if tile == "#" {
                    found = true
                    count += 1
                }
            }
        }
        if value == "#" {
            next[point] = count != 1 ? "." : "#"
        }
        else if value == "." {
            next[point] = count == 1 || count == 2 ? "#" : "."
        }
    }
    return next
}

func print(grid: [Point: String]) {
    var output: [[String]] = input
    for (p,v) in grid {
        output[p.x][p.y] = v
    }
    print(output)
}

func getGrid(_ grid: [Point: String]) -> [[String]] {
    var output: [[String]] = input
    for (p,v) in grid {
        output[p.x][p.y] = v
    }
    return output
}

func compare(_ a: [Point: String],_ b: [Point: String]) -> Bool {
    var aG: [[String]] = input
    var bG: [[String]] = input
    for (p,v) in a {
        aG[p.x][p.y] = v
    }
    for (p,v) in b {
        bG[p.x][p.y] = v
    }
    return aG == bG
}

func rating(_ grid: [Point: String]) -> Int {
    let g = getGrid(grid)
    var score = 0
    var p2 = 1

    for i in 0..<g.count {
        for j in 0..<g[i].count {
            if g[i][j] == "#" {
                score += p2
            }
            p2 *= 2
        }
    }
    return score
}

func partOne() {
    var current: [Point: String] = grid
    var seen: Set<Int> = []
    while true {
        let score = rating(current)
        if seen.contains(score) {
            print(score)
            break
        }
        seen.insert(score)
        current = tick(current)
    }
}

partOne()
