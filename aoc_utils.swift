// grid 

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y)"
        }
    }

    func adjacent() -> [Point] {
        return [
            Point.init(x: x-1, y: y),
            Point.init(x: x+1, y: y),
            Point.init(x: x, y: y-1),
            Point.init(x: x, y: y+1),
            Point.init(x: x-1, y: y-1),
            Point.init(x: x+1, y: y+1),
            Point.init(x: x+1, y: y-1),
            Point.init(x: x-1, y: y+1)
        ]
    }
}

struct Tile: CustomStringConvertible, Equatable, Hashable {
    var row: Int
    var col: Int

    var description: String {
        get {
            return "Row: \(self.row) Col: \(self.col)"
        }
    }

    func adjacent() -> [Point] {
        return [
            Tile.init(x: x-1, y: y),
            Tile.init(x: x+1, y: y),
            Tile.init(x: x, y: y-1),
            Tile.init(x: x, y: y+1),
            Tile.init(x: x-1, y: y-1),
            Tile.init(x: x+1, y: y+1),
            Tile.init(x: x+1, y: y-1),
            Tile.init(x: x-1, y: y+1)
        ]
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

// comparing two dictionary

public func ==<K, L: Hashable, R: Hashable>(lhs: [K: L], rhs: [K: R] ) -> Bool {
    (lhs as NSDictionary).isEqual(to: rhs)
}

// extensions
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

// combinators

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
