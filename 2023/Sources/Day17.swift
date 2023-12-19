import Algorithms
import Collections

struct Day17: AdventDay {
    typealias Grid = Grid2d<Character>
    var data: String

    var input: [String] {
        data.lines
    }

    enum Direction: String, CustomStringConvertible, Hashable, CaseIterable {
        case right = "right"
        case left = "left"
        case up = "up"
        case down = "down"

        var description: String {
            rawValue
        }
    }

    struct HeapItem: Comparable, Hashable {
        static func < (lhs: Day17.HeapItem, rhs: Day17.HeapItem) -> Bool {
            lhs.weight < rhs.weight
        }

        static func == (lhs: Day17.HeapItem, rhs: Day17.HeapItem) -> Bool {
            lhs.point == rhs.point && lhs.direction == rhs.direction
                && lhs.noTurnDistance == rhs.noTurnDistance && lhs.weight == rhs.weight
        }

        let point: Point
        let direction: Direction
        let priority: Int
        let noTurnDistance: Int
        let weight: Int

        func getTitle() -> Title {
            Title(point: self.point, direction: self.direction, noTurnDistance: self.noTurnDistance)
        }
    }

    struct Title: Hashable {
        let point: Point
        let direction: Direction
        let noTurnDistance: Int
    }

    func neighbours(_ point: Point, _ direction: Direction?) -> [(Point, Direction)] {
        guard let direction = direction else {
            return [
                (move(point, .right), .right),
                (move(point, .up), .up),
                (move(point, .down), .down),
                (move(point, .left), .left),
            ]
        }

        switch direction {
        case .right:
            return [
                (move(point, .up), .up),
                (move(point, .right), .right),
                (move(point, .down), .down),
            ]
        case .left:
            return [
                (move(point, .up), .up),
                (move(point, .left), .left),
                (move(point, .down), .down),
            ]
        case .up:
            return [
                (move(point, .left), .left),
                (move(point, .up), .up),
                (move(point, .right), .right),
            ]
        case .down:
            return [
                (move(point, .left), .left),
                (move(point, .down), .down),
                (move(point, .right), .right),
            ]
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

    func search(_ grid: Grid, _ start: Point, _ end: Point, _ isPart2: Bool) -> Int {
        func getValue(_ point: Point) -> Int {
            Int(String(grid.grid[point]!))!
        }

        let startHeapItem = HeapItem(
            point: start,
            direction: .right,
            priority: 1,
            noTurnDistance: 1,
            weight: 0
        )
        var frontier: Heap<HeapItem> = []
        frontier.insert(startHeapItem)
        var costSoFar: [Title: Int] = [:]
        costSoFar[startHeapItem.getTitle()] = 0
        var visited: Set<Title> = []
        var ans = 0

        outer: while let current = frontier.popMin() {
            let currentPoint = current.point
            let currentDirection = current.direction
            let noTurnDistance = current.noTurnDistance

            if currentPoint == end {
                ans = current.weight
                break
            }

            if visited.contains(current.getTitle()) {
                continue outer
            }
            visited.insert(current.getTitle())

            inner: for npd in neighbours(currentPoint, currentDirection) {
                let next = npd.0
                let direction = npd.1
                let newNoTurnDistance = currentDirection == direction ? noTurnDistance + 1 : 1

                guard grid.grid.keys.contains(next) else { continue inner }

                if isPart2 {
                    if !(newNoTurnDistance <= 10
                        && (direction == currentDirection || noTurnDistance >= 4))
                    {
                        continue
                    }
                }
                else {
                    if newNoTurnDistance > 3 {
                        continue inner
                    }
                }

                let newCost = current.weight + getValue(next)
                let priority = newCost + end.distance(next)
                let item = HeapItem(
                    point: next,
                    direction: direction,
                    priority: priority,
                    noTurnDistance: newNoTurnDistance,
                    weight: newCost
                )

                if costSoFar.keys.contains(item.getTitle()) {
                    if costSoFar[item.getTitle()] == nil && newCost <= costSoFar[item.getTitle()]! {
                        costSoFar[item.getTitle()] = newCost
                        frontier.insert(item)
                    }
                }
                else {
                    costSoFar[item.getTitle()] = newCost
                    frontier.insert(item)
                }
            }
        }

        return ans
    }

    func part1() -> Any {
        let grid = Grid(input)
        return search(
            grid,
            Point(x: 0, y: 0),
            Point(x: grid.colCount - 1, y: grid.rowCount - 1),
            false
        )
    }

    func part2() -> Any {
        let grid = Grid(input)
        return search(
            grid,
            Point(x: 0, y: 0),
            Point(x: grid.colCount - 1, y: grid.rowCount - 1),
            true
        )
    }
}
