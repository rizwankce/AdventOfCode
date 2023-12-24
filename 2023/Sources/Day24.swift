import Algorithms
import Foundation

struct Day24: AdventDay {
    var data: String

    var input: [String] {
        data.lines
    }

    struct Point3: CustomStringConvertible, Equatable, Hashable {
        var x: Decimal
        var y: Decimal
        var z: Decimal

        var description: String {
            return "(X:\(self.x) Y:\(self.y) Z:\(self.z))"
        }

        init(x: Decimal, y: Decimal, z: Decimal) {
            self.x = x
            self.y = y
            self.z = z
        }

        init(_ line: String) {
            let com = line.numbersDecimal
            self.x = com[0]
            self.y = com[1]
            self.z = com[2]
        }

        func tick(_ poDecimal: Point3) -> Point3 {
            Point3(x: x + poDecimal.x, y: y + poDecimal.y, z: z + poDecimal.z)
        }
    }

    func parse() -> [(Point3, Point3)] {
        var result: [(Point3, Point3)] = []
        for line in input {
            let com = line.components(separatedBy: " @ ")
            let left = Point3(com[0])
            let right = Point3(com[1])
            result.append((left, right))
        }
        return result
    }

    func linesDecimalersect(_ line1: (Point3, Point3), _ line2: (Point3, Point3)) -> Point3? {
        let xdiff = (line1.0.x - line1.1.x, line2.0.x - line2.1.x)
        let ydiff = (line1.0.y - line1.1.y, line2.0.y - line2.1.y)

        func det(_ a: (Decimal, Decimal), _ b: (Decimal, Decimal)) -> Decimal {
            return (a.0 * b.1) - (a.1 * b.0)
        }

        let div = det(xdiff, ydiff)
        if div == 0 {
            return nil
        }
        let l1 = det((line1.0.x, line1.0.y), (line1.1.x, line1.1.y))
        let l2 = det((line2.0.x, line2.0.y), (line2.1.x, line2.1.y))
        let d = (l1, l2)
        let x = det(d, xdiff) / div
        let y = det(d, ydiff) / div
        return Point3(x: x, y: y, z: 0)
    }

    func isValid(_ intersection: Point3, _ start: Decimal, _ end: Decimal) -> Bool {
        start <= intersection.x && intersection.x <= end
            && start <= intersection.y && intersection.y <= end
    }

    func intersectionAtTestArea(_ start: Decimal, _ end: Decimal) -> Decimal {
        let pv = parse()
        var ans: Decimal = 0
        for com in pv.combinations(ofCount: 2) {
            let left = com[0]
            let right = com[1]
            let leftTick = left.0.tick(left.1)
            let rightTick = right.0.tick(right.1)
            let intersection = linesDecimalersect((left.0, leftTick), (right.0, rightTick))

            guard let intersection = intersection else { continue }

            var dx = intersection.x - left.0.x
            var dy = intersection.y - left.0.y

            guard ((dx > 0) == (left.1.x > 0)) && ((dy > 0) == (left.1.y > 0)) else {
                continue
            }

            dx = intersection.x - right.0.x
            dy = intersection.y - right.0.y
            guard ((dx > 0) == (right.1.x > 0)) && ((dy > 0) == (right.1.y > 0)) else {
                continue
            }

            if isValid(intersection, start, end) {
                ans += 1
            }
        }

        return ans
    }

    func part1() -> Any {
        intersectionAtTestArea(200_000_000_000_000, 400_000_000_000_000)
    }

    func part2() -> Any {
        return ""
    }
}
