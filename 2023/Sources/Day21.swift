import Algorithms

struct Day21: AdventDay {
    typealias Grid = Grid2d<Character>
    var data: String

    var input: [String] {
        data.lines
    }

    func part1() -> Any {
        let grid = Grid(input)
        var start: Point = Point(x: 0, y: 0)
        for x in 0..<grid.colCount {
            for y in 0..<grid.rowCount {
                let p = Point(x: x, y: y)
                if grid.grid[p] == "S" {
                    start = p
                }
            }
        }

        var possible: Set<Point> = []
        var queque: [Point] = [start]
        var step = 0
        while true {
            step += 1
            while !queque.isEmpty {
                let current = queque.removeFirst()

                let nexts = current.adjacent()

                for next in nexts {
                    if grid.grid.keys.contains(next) {
                        if grid.grid[next] != "#" {
                            possible.insert(next)
                        }
                    }
                }
            }
            queque = Array(possible)
            //print("Step: \(step) Possible: \(possible.count)")

            if step == 64 {
                break
            }
            possible = []
        }

        for p in possible {
            grid.grid[p] = "$"
        }

        return possible.count
    }

    func part2() -> Any {
        return ""
    }
}
