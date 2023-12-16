import Algorithms

struct Day16: AdventDay {
    typealias Grid = Grid2d<Character>
    var data: String

    var input: [String] {
        data.lines
    }

    enum Direction: String, CustomStringConvertible, Hashable {
        case right = "right"
        case left = "left"
        case up = "up"
        case down = "down"

        var description: String {
            rawValue
        }
    }

    func move(_ point: Point, _ direction: Direction) -> Point {
        switch direction {
        case .right:
            return Point(x: point.x + 1, y: point.y)

        case .left:
            return Point(x: point.x - 1, y: point.y)

        case .up:
            return Point(x: point.x, y: point.y - 1)

        case .down:
            return Point(x: point.x, y: point.y + 1)
        }
    }

    struct Title: Hashable, CustomStringConvertible {
        let point: Point
        let dir: Direction

        var description: String {
            "\(point) \(dir)"
        }
    }

    func energizedTitles(_ grid: Grid, _ startTitle: Title) -> Int {
        var cur: [Title] = [startTitle]
        var visited: Set<Title> = []
        var seen: Set<Point> = []
        while true {
            if cur.isEmpty {
                break
            }
            var nextTitles: [Title] = []
            for current in cur {
                let next = move(current.point, current.dir)
                if visited.contains(current) {
                    continue
                }
                visited.insert(current)
                if current.point != startTitle.point {
                    seen.insert(current.point)
                }

                guard let value = grid.grid[next] else { continue }
                switch value {
                case ".":
                    nextTitles.append(Title(point: next, dir: current.dir))

                case "/":
                    switch current.dir {
                    case .right:
                        nextTitles.append(Title(point: next, dir: .up))
                    case .left:
                        nextTitles.append(Title(point: next, dir: .down))
                    case .up:
                        nextTitles.append(Title(point: next, dir: .right))
                    case .down:
                        nextTitles.append(Title(point: next, dir: .left))
                    }

                case "\\":
                    switch current.dir {
                    case .right:
                        nextTitles.append(Title(point: next, dir: .down))
                    case .left:
                        nextTitles.append(Title(point: next, dir: .up))
                    case .up:
                        nextTitles.append(Title(point: next, dir: .left))
                    case .down:
                        nextTitles.append(Title(point: next, dir: .right))
                    }

                case "|":
                    switch current.dir {
                    case .right:
                        nextTitles.append(Title(point: next, dir: .up))
                        nextTitles.append(Title(point: next, dir: .down))
                    case .left:
                        nextTitles.append(Title(point: next, dir: .up))
                        nextTitles.append(Title(point: next, dir: .down))
                    case .up, .down:
                        nextTitles.append(Title(point: next, dir: current.dir))
                    }

                case "-":
                    switch current.dir {
                    case .right, .left:
                        nextTitles.append(Title(point: next, dir: current.dir))
                    case .up:
                        nextTitles.append(Title(point: next, dir: .left))
                        nextTitles.append(Title(point: next, dir: .right))
                    case .down:
                        nextTitles.append(Title(point: next, dir: .left))
                        nextTitles.append(Title(point: next, dir: .right))
                    }

                default:
                    fatalError()
                }
            }
            cur = nextTitles
        }
        return seen.count
    }

    func part1() -> Any {
        energizedTitles(Grid(input), Title(point: move(Point(x: 0, y: 0), .left), dir: .right))
    }

    func part2() -> Any {
        let grid = Grid(input)
        var ans = 0

        grid.getColumns(0).forEach {
            ans = max(ans, energizedTitles(grid, Title(point: move($0, .left), dir: .right)))
        }

        grid.getColumns(grid.colCount - 1).forEach {
            ans = max(ans, energizedTitles(grid, Title(point: move($0, .right), dir: .left)))
        }

        grid.getRows(0).forEach {
            ans = max(ans, energizedTitles(grid, Title(point: move($0, .up), dir: .down)))
        }

        grid.getRows(grid.rowCount - 1).forEach {
            ans = max(ans, energizedTitles(grid, Title(point: move($0, .down), dir: .up)))
        }

        return ans
    }
}
