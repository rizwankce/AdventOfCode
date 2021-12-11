import Foundation

// MARK: -  grid

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }

    func neighbours() -> [Point] {
        var points: [Point] = []
        for x in [-1,0,1] {
            for y in [-1,0,1] {
                points.append(Point.init(x: self.x + x, y: self.y + y))
            }
        }
        points.removeAll(where: { $0 == self })
        return points
    }

    func adjacent() -> [Point] {
        var points: [Point] = []
        for x in [-1,0,1] {
            for y in [-1,0,1] {
                if x == 0 || y == 0 {
                    points.append(Point.init(x: self.x + x, y: self.y + y))
                }
            }
        }
        points.removeAll(where: { $0 == self })
        return points
    }
}

struct Grid {
    typealias Cell = [Point: Int]

    var grid: Cell = [:]
    let rowCount: Int
    let colCount: Int

    init(_ input: [String]) {
        self.rowCount = input[0].count
        self.colCount = input.count

        input.enumerated().forEach { (i,line) in
            line.enumerated().forEach { (j,char) in
                let p = Point.init(x: i, y: j)
                grid[p] = Int(String(char))!
            }
        }
    }

    func debugPrint() {
        print("grid start")
        print("rc", separator: "", terminator: " ")
        (0 ..< rowCount).map {
            print($0, separator: " ", terminator: " ")
        }
        print("\n\n")
        for r in (0 ..< rowCount) {
            print(r, separator: " ", terminator: "  ")
            for c in (0 ..< colCount) {
                let p = Point(x: r, y: c)
                print(grid[p]!, separator: " ", terminator: " ")
            }
            print("\n")
        }
        print("grid end")
    }

    func adjacentValues(_ p: Point) -> [Int] {
        p.adjacent().compactMap { grid[$0] }
    }

    func neighbourValues(_ p: Point) -> [Int] {
        p.neighbours().compactMap { grid[$0] }
    }
}

/*
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
 */

// MARK: -  Direction

extension Point {
    mutating func move(_ count: Int,_ dir: Direction) {
        switch dir {
        case .east: x += count
        case .west: x -= count
        case .south: y += count
        case .north: y -= count
        default: fatalError()
        }
    }
}


enum Direction: String {
    case east = "E"
    case west = "W"
    case south = "S"
    case north = "N"
    case left = "L"
    case right = "R"
    case forward = "F"

    mutating func turn(_ deg: Int, _ dir: Direction) {

        assert(deg != 90 || deg != 180 || deg != 270)

        switch self {
        case .east:
            if deg == 90 {
                if dir == .right {
                    self = .south
                }
                if dir == .left {
                    self = .north
                }
            }

            if deg == 270 {
                if dir == .right {
                    self = .north
                }
                if dir == .left {
                    self = .south
                }
            }

            if deg == 180 {
                self = .west
            }

        case .west:
            if deg == 90 {
                if dir == .right {
                    self = .north
                }
                if dir == .left {
                    self = .south
                }
            }

            if deg == 270 {
                if dir == .right {
                    self = .south
                }
                if dir == .left {
                    self = .north
                }
            }

            if deg == 180 {
                self = .east
            }

        case .south:
            if deg == 90 {
                if dir == .right {
                    self = .west
                }
                if dir == .left {
                    self = .east
                }
            }

            if deg == 180 {
                self = .north
            }

            if deg == 270 {
                if dir == .right {
                    self = .east
                }
                if dir == .left {
                    self = .west
                }
            }
        case .north:
            if deg == 90 {
                if dir == .right {
                    self = .east
                }
                if dir == .left {
                    self = .west
                }
            }

            if deg == 270 {
                if dir == .right {
                    self = .west
                }
                if dir == .left {
                    self = .east
                }
            }

            if deg == 180 {
                self = .south
            }

        default:
            fatalError()
        }
    }
}

var grid: [Point: String] = [:]
var maxX: Int = input.count
var maxY: Int = input[0].count

input.enumerated().forEach { (i,line) in
    line.enumerated().forEach { (j,char) in
        let p = Point.init(x: i, y: j)
        grid[p] = String(char)
    }
}

print("max x : \(maxY)")
print("max y : \(maxY)")

func printGrid(_ grid: [Point: String]) {
    print("grid start")
    for x in (0..<maxX) {
        for y in (0..<maxY) {
            let p = Point.init(x: x, y: y)
            print(grid[p]!, separator: " ", terminator: "")
        }
        print("\n")
    }
    print("grid end")
}

// MARK: - Comparing two dictionary

public func ==<K, L: Hashable, R: Hashable>(lhs: [K: L], rhs: [K: R] ) -> Bool {
    (lhs as NSDictionary).isEqual(to: rhs)
}

// MARK: - Int to Bits

extension Int {
    var bits: [Int] {
        var array: [Int] = []
        var copy = self
        while copy > 0 {
            array.append(copy % 2)
            copy /= 2
        }
        return array.reversed()
    }
}

// MARK: - Array int value

extension Array where Element == Int {
    var intValue: Int {
        var value = 0
        for element in self {
            value *= 2
            value += element
        }
        return value
    }
}

// MARK: - Uniques from Array

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}

// MARK: - Combinators

func combos<T>(elements: ArraySlice<T>, k: Int) -> [[T]] {
    if k == 0 {
        return [[]]
    }

    guard let first = elements.first else {
        return []
    }

    let head = [first]
    let subcombos = combos(elements: elements, k: k - 1)
    var ret = subcombos.map { head + $0 }
    ret += combos(elements: elements.dropFirst(), k: k)

    return ret
}

func combos<T>(elements: Array<T>, k: Int) -> [[T]] {
    return combos(elements: ArraySlice(elements), k: k)
}
