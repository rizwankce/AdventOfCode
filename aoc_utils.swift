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

