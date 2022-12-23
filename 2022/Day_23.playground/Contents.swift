import Cocoa

let input = load(.input, runFromTerminal:true).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)
enum Direction {
    case north
    case south
    case east
    case west
    case northEast
    case northWest
    case southEast
    case southWest
}

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
    
    func move(_ direction: Direction) -> Point {
        switch direction {
        case .north: return Point(x: x-1, y: y)
        case .south: return Point(x: x+1, y: y)
        case .east: return Point(x: x, y: y+1)
        case .west: return Point(x: x, y: y-1)
        case .southEast: return Point(x: x+1, y: y+1)
        case .southWest: return Point(x: x+1, y: y-1)
        case .northEast: return Point(x: x-1, y: y+1)
        case .northWest: return Point(x: x-1, y: y-1)
        }
    }
    /*
     If there is no Elf in the N, NE, or NW adjacent positions, the Elf proposes moving north one step.
     If there is no Elf in the S, SE, or SW adjacent positions, the Elf proposes moving south one step.
     If there is no Elf in the W, NW, or SW adjacent positions, the Elf proposes moving west one step.
     If there is no Elf in the E, NE, or SE adjacent positions, the Elf proposes moving east one step.
     */
    
    func neighboursInOrder() -> [Direction: [Point]] {
        return [
            .north:[self.move(.north), self.move(.northEast), self.move(.northWest)],
            .south:[self.move(.south), self.move(.southEast), self.move(.southWest)],
            .west:[self.move(.west), self.move(.northWest), self.move(.southWest)],
            .east:[self.move(.east), self.move(.northEast), self.move(.southEast)]
        ]
    }
}

struct Grid {
    typealias Cell = [Point: String]

    var grid: Cell = [:]
    let rowCount: Int
    let colCount: Int
    
    init(_ input: [String]) {
        self.rowCount = input[0].count
        self.colCount = input.count

        input.enumerated().forEach { (i,line) in
            line.enumerated().forEach { (j,char) in
                let p = Point.init(x: i, y: j)
                grid[p] = String(char)
            }
        }
    }

    func show(_ ps: Set<Point>) {
        let sortedX = ps.sorted(by: { p1,p2  in
            p1.x < p2.x
        }).map { $0.x }
        let sortedY = ps.sorted(by: { p1,p2  in
            p1.y < p2.y
        }).map { $0.y }
        print(sortedX, sortedY)
        let minX = sortedX.min()!
        let maxX = sortedX.max()!
        let minY = sortedY.min()!
        let maxY = sortedY.max()!
        print("rc", separator: "", terminator: " ")
        (minY-1 ... maxY+1).map {
            print($0, separator: " ", terminator: " ")
        }
        print("\n\n")
        for x in minX-1 ... maxX+1 {
            print(abs(x), separator: " ", terminator: " ")
            var row = ""
            for y in minY-1 ... maxY+1 {
                let p = Point(x: x, y: y)
                if ps.contains(p) {
                    row += "#"
                }
                else {
                    row += "."
                }
                row += " "
            }
            print(row)
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
                print(grid[p, default: ""], separator: " ", terminator: " ")
            }
            print("\n")
        }
        print("grid end")
    }
    
    func emptyCounts(_ ps: Set<Point>) -> Int {
        let sortedX = ps.sorted(by: { p1,p2  in
            p1.x < p2.x
        }).map { $0.x }
        let sortedY = ps.sorted(by: { p1,p2  in
            p1.y < p2.y
        }).map { $0.y }
        let minX = sortedX.min()!
        let maxX = sortedX.max()!
        let minY = sortedY.min()!
        let maxY = sortedY.max()!
        
        var ans = 0
        for x in minX ... maxX {
            for y in minY ... maxY {
                let p = Point(x: x, y: y)
                if !ps.contains(p) {
                    ans += 1
                }
            }
        }
        return ans
    }
    
    func makeRound(_ findCycle: Bool) -> Int {
        var points =  Set(grid.filter { $0.value == "#" }.keys)
        var moves: [Direction] = [.north, .south, .west, .east]
        
        for r in 1... {
//            print("Round: \(r)")
            var new: [Point: [Point]] = [:]
            var moved = false

            for point in points {
                if point.neighbours().filter({ points.contains($0) }).count == 0 {
                    continue
                }
                /*
                 If there is no Elf in the N, NE, or NW adjacent positions, the Elf proposes moving north one step.
                 If there is no Elf in the S, SE, or SW adjacent positions, the Elf proposes moving south one step.
                 If there is no Elf in the W, NW, or SW adjacent positions, the Elf proposes moving west one step.
                 If there is no Elf in the E, NE, or SE adjacent positions, the Elf proposes moving east one step.
                 */
                for move in moves {
                    let nextMoves = point.neighboursInOrder()
                    let nms = nextMoves[move]!
                    if nms.filter({ points.contains($0) }).count == 0 {
                        new[point.move(move), default: []].append(point)
                        break
                    }
                }
                
            }
            
            moves.append(moves.removeFirst())
            /*
             each Elf moves to their proposed destination tile if they were the only Elf to propose moving to that position. If two or more Elves propose moving to the same position, none of those Elves move.
             */

            for (k,v) in new {
                if v.count == 1 {
                    moved = true
                    points.remove(v[0])
                    points.insert(k)
                }
            }
            if !moved {
                return r
            }
            
            if !findCycle && r == 10 {
                return emptyCounts(points)
            }
        }
        
        fatalError("unexpected behaviour")
    }

}

let grid = Grid(input)
func partOne() -> CustomStringConvertible {
    return grid.makeRound(false)
}

func partTwo() -> CustomStringConvertible {
    return grid.makeRound(true)
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

enum PuzzleInput: String {
    case input = "input"
    case test  = "test_input"
}

func load(_ input: PuzzleInput, runFromTerminal: Bool = false) -> String {
    switch input {
    case .input:
        return load(file: "input", runFromTerminal)
    default:
        return load(file: "test_input", runFromTerminal)
    }
}

func load(file name: String, _ runFromTerminal: Bool = false) -> String {

    if runFromTerminal {
        let projectURL = URL(fileURLWithPath: #file)
                .deletingLastPathComponent()
                .appendingPathComponent("Resources")
        let fileURL = projectURL.appendingPathComponent(name+".txt")
        guard let content = try? String(contentsOf: fileURL, encoding: .utf8) else {
            fatalError("Cannot convert file contents to string for file :\(name)")
        }

        return content
    }

    guard let url = Bundle.main.url(forResource: name, withExtension: "txt") else {
        fatalError("Cannot load file with name :\(name)")
    }

    guard let content = try? String(contentsOf: url, encoding: .utf8) else {
        fatalError("Cannot convert file contents to string for file :\(name)")
    }

    return content
}
