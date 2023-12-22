import Algorithms

struct Day22: AdventDay {
    var data: String

    var input: [String] {
        data.lines
    }

    struct Point3: CustomStringConvertible, Equatable, Hashable {
        var x: Int
        var y: Int
        var z: Int

        var description: String {
            return "(X:\(self.x) Y:\(self.y) Z:\(self.z))"
        }

        init(x: Int, y: Int, z: Int) {
            self.x = x
            self.y = y
            self.z = z
        }

        init(_ line: String) {
            let com = line.components(separatedBy: ",").map { Int($0)! }
            self.x = com[0]
            self.y = com[1]
            self.z = com[2]
        }

        func moveDown() -> Point3 {
            Point3.init(x: x, y: y, z: z - 1)
        }
    }

    struct Brick: Hashable, CustomStringConvertible {
        var description: String {
            "\(name) :\(start) - \(end)"
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(full)
        }

        let name: Int
        let start: Point3
        let end: Point3
        var full: [Point3]

        func moveDown() -> Brick {
            let ns = start.moveDown()
            let ne = end.moveDown()
            let nf = full.map { $0.moveDown() }
            return Brick(name: name, start: ns, end: ne, full: nf)
        }
    }

    func expand(_ start: Point3, _ end: Point3) -> [Point3] {
        var expanded: [Point3] = []

        // Determine the axis to vary
        var axis: Character = "x"
        var path: KeyPath<Point3, Int>?
        if start.y == end.y && start.z == end.z {
            path = \.x
            axis = "x"
        }
        else if start.x == end.x && start.z == end.z {
            path = \.y
            axis = "y"
        }
        else if start.x == end.x && start.y == end.y {
            path = \.z
            axis = "z"
        }

        // Expand the range along the selected axis
        let range: ClosedRange<Int> = (start[keyPath: path!]...end[keyPath: path!])
        for value in range {
            var point = start
            switch axis {
            case "x":
                point.x = value
            case "y":
                point.y = value
            case "z":
                point.z = value
            default:
                break
            }
            expanded.append(point)
        }

        return expanded
    }

    func fall(_ bricks: [Brick]) -> ([Brick], Int) {
        var bricks = bricks
        var fallen: Set<Point3> = []
        var fallenBrick: Set<Int> = []
        bricks.forEach({ $0.full.forEach { fallen.insert($0) } })

        while true {
            var found = false

            for (idx, brick) in bricks.enumerated() {
                var canFall = true
                for p in brick.full {
                    if p.z == 1 {
                        canFall = false
                    }
                    let next = p.moveDown()
                    if fallen.contains(next) && !brick.full.contains(next) {
                        canFall = false
                    }
                }

                if canFall {
                    fallenBrick.insert(idx)
                    found = true
                    for p in brick.full {
                        fallen.remove(p)
                        fallen.insert(p.moveDown())
                    }
                    let b = bricks[idx]
                    bricks[idx] = b.moveDown()
                }
            }

            if !found {
                break
            }
        }
        return (bricks, fallenBrick.count)
    }

    func parse() -> [Brick] {
        var bricks: [Brick] = []
        for (idx, line) in input.enumerated() {
            let range = line.components(separatedBy: "~").map { Point3($0) }
            let start = range[0]
            let end = range[1]
            let expanded = expand(start, end)
            bricks.append(Brick(name: idx, start: start, end: end, full: expanded))
        }
        return bricks
    }

    func part1() -> Any {
        let bricks = parse()
        let settled = fall(bricks)
        var ans = 0
        for brick in settled.0 {
            let newBricks = settled.0.filter { $0 != brick }
            let fallen = fall(newBricks)
            if fallen.1 == 0 {
                ans += 1
            }
        }

        return ans
    }

    func part2() -> Any {
        let bricks = parse()
        let settled = fall(bricks)
        var ans = 0
        for brick in settled.0 {
            let newBricks = settled.0.filter { $0 != brick }
            let fallen = fall(newBricks)
            if fallen.1 != 0 {
                ans += fallen.1
            }
        }

        return ans
    }
}
