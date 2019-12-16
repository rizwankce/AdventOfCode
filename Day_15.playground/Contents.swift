import Cocoa

let input = """
3,1033,1008,1033,1,1032,1005,1032,31,1008,1033,2,1032,1005,1032,58,1008,1033,3,1032,1005,1032,81,1008,1033,4,1032,1005,1032,104,99,101,0,1034,1039,102,1,1036,1041,1001,1035,-1,1040,1008,1038,0,1043,102,-1,1043,1032,1,1037,1032,1042,1106,0,124,101,0,1034,1039,101,0,1036,1041,1001,1035,1,1040,1008,1038,0,1043,1,1037,1038,1042,1105,1,124,1001,1034,-1,1039,1008,1036,0,1041,1002,1035,1,1040,1001,1038,0,1043,1001,1037,0,1042,1106,0,124,1001,1034,1,1039,1008,1036,0,1041,102,1,1035,1040,1002,1038,1,1043,102,1,1037,1042,1006,1039,217,1006,1040,217,1008,1039,40,1032,1005,1032,217,1008,1040,40,1032,1005,1032,217,1008,1039,9,1032,1006,1032,165,1008,1040,33,1032,1006,1032,165,1101,2,0,1044,1106,0,224,2,1041,1043,1032,1006,1032,179,1102,1,1,1044,1106,0,224,1,1041,1043,1032,1006,1032,217,1,1042,1043,1032,1001,1032,-1,1032,1002,1032,39,1032,1,1032,1039,1032,101,-1,1032,1032,101,252,1032,211,1007,0,53,1044,1106,0,224,1101,0,0,1044,1106,0,224,1006,1044,247,1001,1039,0,1034,101,0,1040,1035,102,1,1041,1036,101,0,1043,1038,101,0,1042,1037,4,1044,1105,1,0,64,32,22,30,60,6,82,30,34,77,7,15,17,32,43,96,51,43,27,74,39,14,10,70,32,20,59,35,98,3,81,47,40,23,65,16,1,82,35,35,44,76,93,55,6,40,65,15,62,62,67,7,72,21,92,85,54,71,42,84,80,30,64,88,50,90,16,34,63,20,88,24,64,86,11,64,20,44,23,63,11,26,10,84,75,13,93,39,16,67,2,91,97,22,86,40,69,11,40,58,93,22,82,30,24,40,58,26,75,70,52,20,27,95,57,23,69,9,30,82,87,70,42,32,90,67,36,92,41,97,72,24,3,36,60,96,5,62,13,74,27,21,60,58,90,17,49,27,70,29,59,48,72,30,35,11,21,60,99,35,37,71,9,84,3,22,74,20,48,70,19,58,65,22,14,72,15,7,31,77,61,5,31,60,24,80,33,58,49,78,80,37,79,66,37,83,4,21,50,65,96,23,67,89,44,17,58,60,41,96,96,39,27,62,84,18,74,38,56,9,72,70,32,62,95,6,87,51,96,36,4,3,79,21,21,31,66,93,13,10,77,43,52,68,66,47,42,55,57,23,60,45,63,3,86,96,29,70,81,31,3,48,38,91,34,69,85,18,95,93,96,85,15,38,80,35,17,98,92,14,57,60,25,46,63,60,16,58,25,48,73,59,40,6,72,46,91,39,22,63,79,58,67,84,33,52,78,52,26,21,61,49,78,77,5,95,75,20,56,30,43,67,75,33,84,10,14,60,21,98,14,31,81,97,49,64,19,69,44,3,68,2,66,20,69,48,81,96,22,56,22,25,27,60,59,36,10,45,81,39,46,97,54,49,42,78,89,26,93,55,14,96,48,48,96,57,51,82,94,23,46,64,20,10,56,19,63,41,77,17,26,68,47,37,97,84,6,93,26,99,1,11,84,12,79,74,34,85,25,48,92,69,68,44,59,35,99,33,88,75,29,12,87,79,37,74,24,98,4,68,1,85,43,31,60,2,82,16,51,65,97,4,82,42,52,82,56,58,24,33,60,22,65,29,43,75,10,72,34,97,70,11,36,89,26,69,84,26,50,17,42,83,44,63,1,84,77,22,89,46,72,79,93,22,94,34,79,48,68,55,3,73,91,30,79,37,76,19,24,61,41,98,32,12,6,57,16,44,55,43,63,55,98,11,68,17,50,67,26,86,19,60,14,56,30,59,11,9,41,26,59,39,56,49,48,82,3,83,64,69,48,65,89,42,78,33,25,91,92,50,91,8,64,73,92,16,96,28,40,27,67,22,69,95,7,12,70,56,49,81,22,68,67,40,48,92,43,14,86,60,49,39,74,58,42,43,54,37,2,84,25,41,22,22,65,16,6,67,62,22,25,88,52,76,88,40,20,75,84,24,4,39,99,51,72,73,14,15,81,39,70,15,26,15,32,34,83,33,73,95,14,55,91,65,81,44,3,89,49,80,5,38,56,42,76,68,14,4,76,71,98,65,62,31,6,96,23,77,82,4,59,91,29,14,91,42,80,35,2,58,99,27,40,64,43,86,74,17,58,68,24,71,51,73,35,74,63,50,17,24,5,83,71,12,62,33,19,31,84,41,25,71,75,41,43,55,85,22,11,88,71,49,33,55,50,63,52,64,23,25,42,85,47,49,30,65,42,95,61,15,86,7,61,62,32,79,62,82,13,84,30,69,21,70,22,99,95,71,5,71,11,69,39,85,79,89,41,94,82,86,46,83,96,80,48,74,63,56,8,58,38,66,12,61,33,88,30,92,27,57,0,0,21,21,1,10,1,0,0,0,0,0,0
""".components(separatedBy: ",").compactMap{ Int($0) }


enum Direction: Int, CaseIterable {
    case north  = 1
    case south  = 2
    case west = 3
    case east = 4

    func next() -> Self {
        switch self {
        case .north:
            return .south
        case .south :
            return .west
        case .west:
            return .east
        case .east:
            return .north
        }
    }
}

enum Status: Int, CustomStringConvertible {
    var description: String {
        get {
            desc()
        }
    }

    func desc() -> String {
        switch self {
        case .wall:
            return "Wall"
        case .moved:
            return "Moved"
        case .oxygen:
            return "Oxygen System"
        }
    }

    case wall = 0
    case moved = 1
    case oxygen = 2
}

struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y)"
        }
    }

    func move(_ direction: Direction) -> Point {
        switch direction {
        case .north:
            return Point.init(x: x, y: y + 1)
        case .south:
            return Point.init(x: x, y: y - 1)
        case .west:
            return Point.init(x: x - 1, y: y)
        case .east:
            return Point.init(x: x + 1, y: y)
        }
    }

    func distance() -> Int {
        return abs(x) + abs(y)
    }
}

class Driod {
    var grid: [Point: Status] = [:]
    var memory: [Int]
    let computer: Opcode

    init(_ memory: [Int]) {
        self.memory = memory
        self.computer = Opcode.init(memory, 0)
    }

    func search() {
        var queue: [Point] = [Point]()
        queue.insert(Point.init(x: 0, y: 0), at: 0)
        var seen:[Point:Opcode] = [Point.init(x: 0, y: 0): Opcode.init(memory)]

        while !queue.isEmpty {
            let currentP = queue.removeLast()
            Direction.allCases.forEach { (direction) in
                let pos = currentP.move(direction)
                guard seen[pos] == nil else { return }
                let computer = seen[currentP]!.clone()
                computer.inputIds.removeAll()
                computer.inputIds.append(direction.rawValue)
                let status = Status.init(rawValue: computer.run())
                seen[pos] = computer
                grid[pos] = status
                if status != .wall {
                    queue.insert(pos, at: 0)
                }
            }
        }
    }

    func stepsToO2() -> Int {
        var queue: Array<(steps:Int,point:Point)> = Array<(steps:Int,point:Point)>()
        queue.insert((steps:0,point:Point.init(x: 0, y: 0)), at: 0)
        var seen: Set<Point> = Set<Point>()
        var stepsToO2 = -1
        while !queue.isEmpty && stepsToO2 == -1 {
            let tuple = queue.removeLast()
            let steps = tuple.steps
            let point = tuple.point
            seen.insert(point)

            Direction.allCases.forEach { (direction) in
                let pos = point.move(direction)
                if !seen.contains(pos) {
                    let status = grid[pos, default: .wall]
                    if status != .wall {
                        queue.insert((steps:steps+1,point:pos), at:0)
                    }
                    if status == .oxygen {
                        stepsToO2 = steps + 1
                    }
                }
            }
        }
        return stepsToO2
    }

    func minToFillO2() -> Int {
        let o2Point = grid.first(where: { $0.value == .oxygen })!.key
        var queue: [Point] = [Point]()
        queue.insert(o2Point, at: 0)
        var seen: Set<Point> = Set<Point>()
        var min = -1

        while !queue.isEmpty {
            var queueNext: [Point] = []
            while !queue.isEmpty {
                let currentP = queue.removeLast()
                seen.insert(currentP)

                Direction.allCases.forEach { (direction) in
                    let pos = currentP.move(direction)

                    guard !seen.contains(pos),
                        grid[pos, default: .wall] == .moved else {
                        return
                    }
                    queueNext.append(pos)
                }
            }
            queue = queueNext
            min += 1
        }

        return min
    }
}

func partOne() {
    let driod = Driod(input)
    driod.search()
    print("Part 1 answer is :\(driod.stepsToO2())")
}

func partTwo() {
    let driod = Driod(input)
    driod.search()
    print("Part 2 answer is :\(driod.minToFillO2())")
}

partOne()
partTwo()
