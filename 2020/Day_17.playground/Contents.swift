import Cocoa

let input = """
..##.#.#
.#####..
#.....##
##.##.#.
..#...#.
.#..##..
.#...#.#
#..##.##
""".components(separatedBy: .newlines)

//print(input)

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int
    var z: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y) Z: \(self.z)"
        }
    }

    func neighbors() -> [Point] {
        var n: [Point] = []
        for dx in [-1,0,1] {
            for dy in [-1,0,1] {
                for dz in [-1,0,1] {
                    if dx != 0 || dy != 0 || dz != 0 {
                        n.append(Point.init(x: x + dx, y: y + dy, z: z + dz))
                    }
                }
            }
        }
        return n
    }
}

struct Point4: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int
    var z: Int
    var w: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y) Z: \(self.z) W: \(self.w)"
        }
    }

    func neighbors() -> [Point4] {
        var n: [Point4] = []
        for dx in [-1,0,1] {
            for dy in [-1,0,1] {
                for dz in [-1,0,1] {
                    for dw in [-1,0,1] {
                        if dx != 0 || dy != 0 || dz != 0 || dw != 0 {
                            n.append(Point4.init(x: x + dx, y: y + dy, z: z + dz, w: w + dw))
                        }
                    }
                }
            }
        }
        return n
    }
}

func parsed3DInput() -> Set<Point> {
    var grid: Set<Point> = []
    input.enumerated().forEach { (i,line) in
        line.enumerated().forEach { (j,char) in
            let p = Point.init(x: i, y: j, z: 0)
            if char == "#" {
                grid.insert(p)
            }
        }
    }
    return grid
}

func parsed4DInput() -> Set<Point4> {
    var grid: Set<Point4> = []
    input.enumerated().forEach { (i,line) in
        line.enumerated().forEach { (j,char) in
            let p = Point4.init(x: i, y: j, z: 0, w: 0)
            if char == "#" {
                grid.insert(p)
            }
        }
    }
    return grid
}

func partOne() -> Int {
    var cur = parsed3DInput()

    for i in (0..<6) {
        print("Cycle : \(i+1)")
        var newG: Set<Point> = []
        var check: Set<Point> = []

        cur.forEach {
            $0.neighbors().forEach {
                check.insert($0)
            }
        }

        for p in check {
            let nCount = p.neighbors().filter({ cur.contains($0) }).count

            if !cur.contains(p) && nCount == 3 {
                newG.insert(p)
            }
            if cur.contains(p) && [2,3].contains(nCount) {
                newG.insert(p)
            }
        }

        cur = newG
    }

    return cur.count
}

func partTwo() -> Int {
    var cur = parsed4DInput()

    for i in (0..<6) {
        print("Cycle : \(i+1)")
        var newG: Set<Point4> = []
        var check: Set<Point4> = []

        cur.forEach {
            $0.neighbors().forEach {
                check.insert($0)
            }
        }

        for p in check {
            let nCount = p.neighbors().filter({ cur.contains($0) }).count

            if !cur.contains(p) && nCount == 3 {
                newG.insert(p)
            }
            if cur.contains(p) && [2,3].contains(nCount) {
                newG.insert(p)
            }
        }

        cur = newG
    }

    return cur.count
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")
