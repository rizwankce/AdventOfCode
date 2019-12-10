import Cocoa

var input = """
#.....#...#.........###.#........#..
....#......###..#.#.###....#......##
......#..###.......#.#.#.#..#.......
......#......#.#....#.##....##.#.#.#
...###.#.#.......#..#...............
....##...#..#....##....#...#.#......
..##...#.###.....##....#.#..##.##...
..##....#.#......#.#...#.#...#.#....
.#.##..##......##..#...#.....##...##
.......##.....#.....##..#..#..#.....
..#..#...#......#..##...#.#...#...##
......##.##.#.#.###....#.#..#......#
#..#.#...#.....#...#...####.#..#...#
...##...##.#..#.....####.#....##....
.#....###.#...#....#..#......#......
.##.#.#...#....##......#.....##...##
.....#....###...#.....#....#........
...#...#....##..#.#......#.#.#......
.#..###............#.#..#...####.##.
.#.###..#.....#......#..###....##..#
#......#.#.#.#.#.#...#.#.#....##....
.#.....#.....#...##.#......#.#...#..
...##..###.........##.........#.....
..#.#..#.#...#.....#.....#...###.#..
.#..........#.......#....#..........
...##..#..#...#..#...#......####....
.#..#...##.##..##..###......#.......
.##.....#.......#..#...#..#.......#.
#.#.#..#..##..#..............#....##
..#....##......##.....#...#...##....
.##..##..#.#..#.................####
##.......#..#.#..##..#...#..........
#..##...#.##.#.#.........#..#..#....
.....#...#...#.#......#....#........
....#......###.#..#......##.....#..#
#..#...##.........#.....##.....#....
""".components(separatedBy: "\n").map{ Array($0) }

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y)"
        }
    }
}

var grid: [Point] = []
_ = input.enumerated().map { (y,layer) in
    _ = layer.enumerated().map { (x,point) in
        if point == "#" {
            grid.append(Point.init(x: x, y: y))
        }
    }
}

extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}

func angleBtw(_ x: Point, _ y: Point) -> Double {
    return (atan2(Double(x.y - y.y), Double(x.x - y.x)) * 180) / Double.pi
}
struct Los: CustomStringConvertible{
    var point: Point
    var angle: Double

    var description: String {
        get {
            return "point: \(self.point) angle: \(self.angle)"
        }
    }
}

func getAstroidsInLOS(_ base: Point) -> [Los] {
    var los: [Los] = []
    let astroids = grid.filter{ $0 != base }
    _ = astroids.map { point in
        let angle = angleBtw(base, point)
        var blocked = false
        _ = los.map { aLos in
            if aLos.angle == angle {
                blocked = true
            }
        }

        if !blocked {
            los.append(Los.init(point: point, angle: angle))
        }
    }
    return los
}

func partOne() {
    let result = grid.map { point -> Int in
        return getAstroidsInLOS(point).count
    }.max()
    print("Part One answer is :\(result ?? 0)")
}

func partTwo() {
    let root = grid.map { point -> (Point,Int) in
        return (point,getAstroidsInLOS(point).count)
    }.max { (p1, p2) -> Bool in
        return p1.1 < p2.1
        }!.0
    var los = getAstroidsInLOS(root)
    los.sort{ a, b in a.angle < b.angle}
    let base = los.firstIndex { (aLos) -> Bool in
        return aLos.angle == 90
    }
    let result = los[199 + (base ?? 0) - los.count]
    print("Part Two is \(result.point.x * 100 + result.point.y)")
}

partOne()
partTwo()
