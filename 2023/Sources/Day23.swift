import Algorithms

struct Day23: AdventDay {
    typealias Grid = Grid2d<Character>

    var data: String

    var input: [String] {
        data.lines
    }

    func nextPoint(_ point: Point, _ char: Character) -> Point {
        switch char {
        case "^": return point.moved(1, .north)
        case ">": return point.moved(1, .east)
        case "v": return point.moved(1, .south)
        case "<": return point.moved(1, .west)
        default: fatalError()
        }
    }

    func part1() -> Any {
        let grid = Grid(input)
        let start = Point(x: 1, y: 0)
        let end = Point(x: grid.colCount - 2, y: grid.rowCount - 1)
        func search(_ grid: Grid, _ start: Point, _ end: Point) -> Int {
            var queue: [(Point, Int, Set<Point>)] = [(start, 0, [])]
            var result = 0

            while !queue.isEmpty {
                let (current, steps, seens) = queue.removeFirst()
                //print(current, steps, seens.count)
                var seen = seens

                if seen.contains(current) {
                    continue
                }
                seen.insert(current)

                if !(grid.grid.keys.contains(current) && grid.grid[current] != "#") {
                    continue
                }

                if current == end {
                    result = max(result, steps)
                    continue
                }

                let lv = grid.grid[current]
                if ["^", ">", "v", "<"].contains(lv) {
                    let next = nextPoint(current, lv!)
                    queue.append((next, steps + 1, seen))
                    continue
                }

                for next in current.adjacent() {
                    if grid.grid.keys.contains(next) {
                        let nv = grid.grid[next]
                        if nv != "#" && !seen.contains(next) {
                            //seen.insert(next)
                            queue.append((next, steps + 1, seen))
                        }
                    }
                }
            }

            return result
        }
        return search(grid, start, end)
    }

    func part2() -> Any {
        let grid = Grid(input)
        let start = Point(x: 1, y: 0)
        let end = Point(x: grid.colCount - 2, y: grid.rowCount - 1)
        func search(_ grid: Grid, _ start: Point, _ end: Point) -> Int {
            var queue: [(Point, Int, Set<Point>)] = [(start, 0, [])]
            var result = 0
            var count = 0

            while !queue.isEmpty {
                let (current, steps, seens) = queue.removeFirst()
                //print(current, steps, seens.count)
                var seen = seens
                count += 1

                if count % 10_000 == 0 {
                    //print(count)
                }

                if seen.contains(current) {
                    continue
                }
                seen.insert(current)

                if !(grid.grid.keys.contains(current) && grid.grid[current] != "#") {
                    continue
                }

                if current == end {
                    result = max(result, steps)
                    print(result)
                    continue
                }

                //                let lv = grid.grid[current]
                //                if ["^", ">", "v", "<"].contains(lv) {
                //                    let next = nextPoint(current, lv!)
                //                    queue.append((next, steps+1, seen))
                //                    continue
                //                }

                for next in current.adjacent() {
                    if grid.grid.keys.contains(next) {
                        let nv = grid.grid[next]
                        if nv != "#" && !seen.contains(next) {
                            //seen.insert(next)
                            queue.append((next, steps + 1, seen))
                        }
                    }
                }
            }

            return result
        }
        return search(grid, start, end)
    }
}
