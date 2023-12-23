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

        func findPath(current: Point, seen: [Point], paths: [Point: [(Point, Int)]]) -> Int {
            if current == end {
                return 0
            }

            var best: Int = 0
            for (adj, steps) in paths[current]! where !seen.contains(adj) {
                if !seen.contains(adj) {
                    let bestFromHere = findPath(current: adj, seen: seen + [adj], paths: paths)
                    best = max(best, bestFromHere + steps)
                }
            }

            return best
        }

        func longestHike(_ grid: Grid, _ start: Point) -> [Point: [(Point, Int)]] {
            var junctions: [Point] = [start, end]
            for kv in grid.grid {
                let point = kv.key
                let value = kv.value

                if value == "." {
                    let nexts = point.adjacent().filter { grid.isValid($0) && grid[$0] != "#" }
                    if nexts.count > 2 {
                        junctions.append(point)
                    }
                }
            }

            junctions = junctions.uniques

            var graph: [Point: [(Point, Int)]] = [:]
            for junction in junctions {
                let adj = junction.adjacent().filter { grid.isValid($0) && grid[$0] != "#" }

                for a in adj {
                    var cur = a
                    var path = [junction, a]
                    inner: while !junctions.contains(cur) {
                        path.append(cur)
                        let nexts = cur.adjacent().filter {
                            grid.isValid($0) && grid[$0] != "#" && !path.contains($0)
                        }

                        if nexts.isEmpty { continue inner }
                        if nexts.count != 1 { break inner }
                        cur = nexts[0]
                    }
                    graph[junction, default: []].append((cur, path.count - 1))
                }
            }
            return graph
        }

        let graph = longestHike(grid, start)
        return findPath(current: start, seen: [start], paths: graph)
    }
}
