import Cocoa

let input = 361527

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }
    
    func adding(_ p: Point) -> Point {
        Point(x: self.x + p.x, y: self.y + p.y)
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
}

func distance(_ p1: Point, _ p2: Point) -> Int {
    abs((p2.x - p1.x)) + abs((p2.y - p1.y))
}

func partOne() -> Int {
    var grid: [Int: Point] = [:]
    var p = Point(x: 0, y: 0)
    let move = [Point(x: 1, y: 0), Point(x:0,y:-1), Point(x: -1, y: 0), Point(x: 0, y: 1)]
    var num = 1
    grid[num] = p
    
    for i in 1 ... 1000 {
        let cur = 2 * i
        p = p.adding(move[0])
        grid[num+1] = p
        num += 1
        for _ in 1 ..< cur {
            let newP = p.adding(move[1])
            grid[num + 1] = newP
            num += 1
            p = newP
        }

        p = p.adding(move[2])
        grid[num + 1] = p
        num += 1
        for _ in 1 ..< cur {
            let newP = p.adding(move[2])
            grid[num + 1] = newP
            num += 1
            p = newP
        }
        
        p = p.adding(move[3])
        grid[num + 1] = p
        num += 1
        for _ in 1 ..< cur {
            let newP = p.adding(move[3])
            grid[num+1] = newP
            num += 1
            p = newP
        }

        
        p = p.adding(move[0])
        grid[num+1] = p
        num += 1
        for _ in 1 ..< cur {
            let newP = p.adding(move[0])
            grid[num+1] = newP
            num += 1
            p = newP
        }
        
        if num >= input {
            break
        }
    }
    
    return distance(grid[input]!, grid[1]!)
}

func partTwo() -> Int {
    var grid: [Point: Int] = [:]
    var p = Point(x: 0, y: 0)
    let move = [Point(x: 1, y: 0), Point(x:0,y:-1), Point(x: -1, y: 0), Point(x: 0, y: 1)]
    grid[p] = 1
    
    for i in 1 ... 100 {
        let cur = 2 * i
        p = p.adding(move[0])
        grid[p] = p.neighbours().map { grid[$0, default: 0] }.reduce(0, +)
        for _ in 1 ..< cur {
            p = p.adding(move[1])
            grid[p] = p.neighbours().map { grid[$0, default: 0] }.reduce(0, +)
        }
        
        p = p.adding(move[2])
        grid[p] = p.neighbours().map { grid[$0, default: 0] }.reduce(0,+)
        for _ in 1 ..< cur {
            p = p.adding(move[2])
            grid[p] = p.neighbours().map { grid[$0, default: 0] }.reduce(0, +)
        }
        
        p = p.adding(move[3])
        grid[p] = p.neighbours().map { grid[$0, default: 0] }.reduce(0, +)
        for _ in 1 ..< cur {
            p = p.adding(move[3])
            grid[p] = p.neighbours().map { grid[$0, default: 0] }.reduce(0, +)
        }
        
        
        p = p.adding(move[0])
        grid[p] = p.neighbours().map { grid[$0, default: 0] }.reduce(0, +)
        for _ in 1 ..< cur {
            p = p.adding(move[0])
            grid[p] = p.neighbours().map { grid[$0, default: 0] }.reduce(0, +)
        }
        
        if grid.values.max()! >= input {
            break
        }
    }

    var result = 0
    for i in grid.values.sorted() {
        if i >= input {
            result = i
            break
        }
    }
    
    return result
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")
