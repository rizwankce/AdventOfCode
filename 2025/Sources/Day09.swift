import Algorithms
import Foundation

struct Day09: AdventDay {
    var data: String

    func parse() -> [Point] {
        data
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: .newlines)
            .map {
                let com = $0.components(separatedBy: ",").map { Int($0)! }
                return Point(x: com[0], y: com[1])
            }
    }

    func area(_ p1: Point, _ p2: Point) -> Int {
        let dx = max(p1.x, p2.x) - min(p1.x, p2.x) + 1
        let dy = max(p1.y, p2.y) - min(p1.y, p2.y) + 1
        if dx == dy {
            return -1
        }
        return dx * dy
    }

    func part1() -> Any {
        let input = parse()

        var areas: [Int] = []
        for i in 0 ..< input.count {
            for j in i+1 ..< input.count {
                let p1 = input[i]
                let p2 = input[j]
                areas.append(area(p1, p2))
            }
        }
        return areas.max()!
    }

    func part2() -> Any {
        func generatePolygon(_ points: [Point]) -> Set<Point> {
            var polygon: Set<Point> = []

            for i in 0 ..< points.count {
                let p1 = points[i]
                let p2 = points[(i + 1) % points.count]

                let xs = p1.x == p2.x
                let ys = p1.y == p2.y

                var ps: [Point] = []

                if xs {
                    ps = (min(p1.y, p2.y) ... max(p1.y, p2.y)).map {
                        Point(x: p1.x, y: $0)
                    }
                }

                if ys {
                    ps = (min(p1.x, p2.x) ... max(p1.x, p2.x)).map {
                        Point(x: $0, y: p1.y)
                    }
                }
                ps.forEach { polygon.insert($0) }
                polygon.insert(p1)
                polygon.insert(p2)
            }
            return polygon
        }

        func edgeCrossesRectangle(_ v1: Point, _ v2: Point, _ minX: Int, _ maxX: Int, _ minY: Int, _ maxY: Int) -> Bool {
            if v1.y == v2.y {
                let y = v1.y
                if y > minY && y < maxY {
                    let edgeMinX = min(v1.x, v2.x)
                    let edgeMaxX = max(v1.x, v2.x)
                    if edgeMinX < maxX && edgeMaxX > minX {
                        return true
                    }
                }
            }
            if v1.x == v2.x {
                let x = v1.x
                if x > minX && x < maxX {
                    let edgeMinY = min(v1.y, v2.y)
                    let edgeMaxY = max(v1.y, v2.y)
                    if edgeMinY < maxY && edgeMaxY > minY {
                        return true
                    }
                }
            }
            return false
        }

        func isRectangleInside(_ minX: Int, _ maxX: Int, _ minY: Int, _ maxY: Int,
                              polygon: [Point]) -> Bool {
            for i in 0 ..< polygon.count {
                let v1 = polygon[i]
                let v2 = polygon[(i + 1) % polygon.count]
                if edgeCrossesRectangle(v1, v2, minX, maxX, minY, maxY) {
                    return false
                }
            }
            return true
        }

        let input = parse()
        let polygonVertices = input

        let polyMinX = input.map { $0.x }.min()!
        let polyMaxX = input.map { $0.x }.max()!
        let polyMinY = input.map { $0.y }.min()!
        let polyMaxY = input.map { $0.y }.max()!

        let polyWidth = polyMaxX - polyMinX + 1
        let polyHeight = polyMaxY - polyMinY + 1

        var areas: [Int] = []

        for i in 0 ..< input.count {
            inner: for j in i+1 ..< input.count {
                let p1 = input[i]
                let p2 = input[j]

                let minX = min(p1.x, p2.x)
                let maxX = max(p1.x, p2.x)
                let minY = min(p1.y, p2.y)
                let maxY = max(p1.y, p2.y)

                let dx = maxX - minX + 1
                let dy = maxY - minY + 1

                if dx == dy {
                    continue inner
                }

                if dx > polyWidth || dy > polyHeight {
                    continue inner
                }

                if maxX < polyMinX || minX > polyMaxX || maxY < polyMinY || minY > polyMaxY {
                    continue inner
                }

                if isRectangleInside(minX, maxX, minY, maxY, polygon: polygonVertices) {
                    areas.append(dx * dy)
                }
            }
        }
        return areas.max() ?? 0
    }
}
