import Algorithms

struct Day10: AdventDay {
    typealias Grid = Grid2d<Character>

    var data: String

    var input: [String] {
        data.lines
    }

    struct PipeMaze {
        let grid: Grid

        init(_ input: [String]) {
            self.grid = Grid(input)
        }

        var cells: [Point: Character] {
            grid.grid
        }

        func next(from point: Point, _ prevPoint: Point, _ char: Character) -> Point {
            /*
             | is a vertical pipe connecting north and south.
             - is a horizontal pipe connecting east and west.
             L is a 90-degree bend connecting north and east.
             J is a 90-degree bend connecting north and west.
             7 is a 90-degree bend connecting south and west.
             F is a 90-degree bend connecting south and east.
             . is ground; there is no pipe in this tile.
             S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.
             */

            switch char {
            case "|":
                if prevPoint.y < point.y {
                    return Point(x: point.x, y: point.y + 1)
                }
                return Point(x: point.x, y: point.y - 1)
            case "-":
                if prevPoint.x < point.x {
                    return Point(x: point.x + 1, y: point.y)
                }
                return Point(x: point.x - 1, y: point.y)
            case "L":
                if point.moved(1, .north) == prevPoint {
                    return point.moved(1, .east)
                }
                return point.moved(1, .north)
            case "J":
                if point.moved(1, .north) == prevPoint {
                    return point.moved(1, .west)
                }
                return point.moved(1, .north)
            case "7":
                if point.moved(1, .south) == prevPoint {
                    return point.moved(1, .west)
                }
                return point.moved(1, .south)
            case "F":
                if point.moved(1, .south) == prevPoint {
                    return point.moved(1, .east)
                }
                return point.moved(1, .south)
            case ".": fatalError()
            case "S": fatalError()
            default: fatalError()
            }
        }

        func loopPoints(_ breakEarly: Bool = false) -> (loop: Set<Point>, length: Int) {
            var start: Point = .init(x: 0, y: 0)

            for cell in cells {
                if cell.value == "S" {
                    start = cell.key
                }
            }

            assert(start != Point(x: 0, y: 0))

            let nexts = start.adjacent().filter { cells[$0, default: "."] != "." }
            var all: [Int] = []
            var visited: Set<Point> = [start]
            for n in nexts {
                var queue: [(point: Point, prevPoint: Point, steps: Int)] = [(n, start, 1)]
                visited = []
                var result = 0
                while !queue.isEmpty {
                    let current = queue.removeFirst()
                    let prevPoint = current.prevPoint
                    let point = current.point
                    let steps = current.steps

                    if point == start {
                        result = steps
                        break
                    }

                    let nP = next(from: point, prevPoint, cells[point]!)
                    queue.append((nP, point, steps + 1))
                    visited.insert(point)
                }

                all.append(result)

                if breakEarly {
                    break
                }
            }

            return (visited, all.max()!)
        }

        func length() -> Int {
            return loopPoints().length
        }

        func numberOfTilesInsideLoop() -> Int {
            let polygon = loopPoints(true).loop
            let notLoop = cells.keys.filter { !polygon.contains($0) }

            var ans = 0
            for n in notLoop {
                if isPoint(n, inPolygon: polygon) {
                    ans += 1
                }
            }
            return ans
        }

        func isPoint(_ p: Point, inPolygon polygon: Set<Point>) -> Bool {
            var count = 0
            for rx in (0..<p.x) {
                let cp = Point(x: rx, y: p.y)
                if !polygon.contains(cp) {
                    continue
                }
                if ["J", "L", "|"].contains(cells[cp]!) {
                    count += 1
                }
            }
            return count % 2 == 1
        }

    }

    func part1() -> Any {
        PipeMaze(input).length() / 2
    }

    func part2() -> Any {
        PipeMaze(input).numberOfTilesInsideLoop()
    }
}
