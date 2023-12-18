import Algorithms

struct Day18: AdventDay {
    var data: String

    var input: [String] {
        data.lines
    }

    enum Direction: String, CaseIterable {
        case up = "U"
        case down = "D"
        case left = "L"
        case right = "R"
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

    struct DigPlan: CustomStringConvertible {
        var description: String {
            "\(direction.rawValue) \(count) \(color)"
        }

        let direction: Direction
        let count: Int
        let color: String

        init(_ line: String, _ isSwapped: Bool = false) {
            // R 6 (#70c710)
            let com = line.components(separatedBy: " ")
            if !isSwapped {
                self.direction = Direction(rawValue: com[0])!
                self.count = Int(com[1])!
                self.color = com[2]
            }
            else {
                let hex = com[2].dropFirst(2).dropLast()
                let count = hex.dropLast(1)
                let dir = hex.dropFirst(5)
                switch dir {
                case "0": self.direction = .right
                case "1": self.direction = .down
                case "2": self.direction = .left
                case "3": self.direction = .up
                default: fatalError()
                }

                self.count = Int(count, radix: 16)!
                self.color = "hex"
            }
        }

        func vertices(_ current: inout Point) {
            switch direction {
            case .up:
                current.x += count * -1
                current.y += count * 0
            case .down:
                current.x += count * 1
                current.y += count * 0
            case .left:
                current.x += count * 0
                current.y += count * -1
            case .right:
                current.x += count * 0
                current.y += count * 1
            }
        }
    }

    func part1() -> Any {
        func windingNumber(point: Point, polygon: [Point]) -> Int {
            var windingNumber = 0
            let n = polygon.count
            for i in 0..<n {
                let p1 = polygon[i]
                let p2 = polygon[(i + 1) % n]
                if p1.y <= point.y {
                    if p2.y > point.y && isLeft(p1, p2, point) > 0 {
                        windingNumber += 1
                    }
                }
                else {
                    if p2.y <= point.y && isLeft(p1, p2, point) < 0 {
                        windingNumber -= 1
                    }
                }
            }
            return windingNumber
        }

        func isLeft(_ p1: Point, _ p2: Point, _ p3: Point) -> Int {
            return (p2.x - p1.x) * (p3.y - p1.y) - (p3.x - p1.x) * (p2.y - p1.y)
        }

        let plans = input.map { DigPlan($0) }
        var cur = Point(x: 0, y: 0)
        var points: [Point] = [cur]

        for plan in plans {
            for _ in 0..<plan.count {
                cur = move(cur, plan.direction)
                points.append(cur)
            }
        }

        var grid: [Point: Character] = [:]
        points.forEach {
            grid[$0] = "#"
        }
        let minX = points.map { $0.x }.min()!
        let maxX = points.map { $0.x }.max()!
        let minY = points.map { $0.y }.min()!
        let maxY = points.map { $0.y }.max()!

        for x in minX...maxX {
            for y in minY...maxY {
                let p = Point(x: x, y: y)
                if !grid.keys.contains(p) {
                    grid[p] = "."
                }
            }
        }

        var ans = points.uniques.count

        for x in minX...maxX {
            for y in minY...maxY {
                let p = Point(x: x, y: y)
                if grid[p]! == "." {
                    if windingNumber(point: p, polygon: points) != 0 {
                        ans += 1
                    }
                }
            }
        }

        return ans
    }

    func part2() -> Any {
        let plans = input.map { DigPlan($0, true) }

        var vertices: [Point] = []
        var perimeter = 0
        var current = Point(x: 0, y: 0)
        for plan in plans {
            plan.vertices(&current)
            vertices.append(current)
            perimeter += plan.count
        }

        func lace(_ verti: [Point]) -> Int {
            var a = 0
            for p in zip(verti, verti.dropFirst()) {
                let r1 = p.0.x
                let r2 = p.1.x
                let c1 = p.0.y
                let c2 = p.1.y
                a += (r2 + r1) * (c2 - c1)
            }

            let first = vertices.first!
            let last = vertices.last!
            let r1 = last.x
            let c1 = last.y
            let r2 = first.x
            let c2 = first.y

            a += (r2 + r1) * (c2 - c1)

            a = abs(a)  // 2
            return a
        }

        return (lace(vertices) - perimeter) / 2 + 1 + perimeter
    }
}
