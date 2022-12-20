import Cocoa

let input = load(.input, runFromTerminal:true).trimmingCharacters(in: .newlines).map { String($0) }

//print(input)
struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "(X:\(self.x) Y:\(self.y))"
        }
    }
    
    func moveLeft() -> Point {
        Point(x: x-1, y: y)
    }
    
    func moveRight() -> Point {
        Point(x: x+1, y: y)
    }
    
    func moveDown() -> Point {
        Point(x: x, y: y-1)
    }
    
    func moveUp() -> Point {
        Point(x: x, y: y+1)
    }
}

typealias Rock = Set<Point>

/*
 ####

 .#.
 ###
 .#.

 ..#
 ..#
 ###

 #
 #
 #
 #

 ##
 ##
 */

func getfallingRock(_ turn: Int, _ maxY: Int) -> Rock {
    var points: [Point] = []
    switch turn {
    case 0:
        points.append(contentsOf: [
            Point(x: 2, y: maxY),
            Point(x: 3, y: maxY),
            Point(x: 4, y: maxY),
            Point(x: 5, y: maxY)
        ])
    case 1:
        points.append(contentsOf: [
            Point(x: 3, y: maxY+2),
            Point(x: 2, y: maxY+1),
            Point(x: 3, y: maxY+1),
            Point(x: 4, y: maxY+1),
            Point(x: 3, y: maxY)
        ])
    case 2:
        points.append(contentsOf: [
            Point(x: 2, y: maxY),
            Point(x: 3, y: maxY),
            Point(x: 4, y: maxY),
            Point(x: 4, y: maxY+1),
            Point(x: 4, y: maxY+2)
        ])
    case 3:
        points.append(contentsOf: [
            Point(x: 2, y: maxY),
            Point(x: 2, y: maxY+1),
            Point(x: 2, y: maxY+2),
            Point(x: 2, y: maxY+3)
        ])
    case 4:
        points.append(contentsOf: [
            Point(x: 2, y: maxY+1),
            Point(x: 2, y: maxY),
            Point(x: 3, y: maxY+1),
            Point(x: 3, y: maxY)
        ])
    default:
        fatalError("unknown rock")
    }
    
    return Set(points)
}

func moveLeft(_ rock: Rock) -> Rock {
    if rock.map({ $0.x }).contains(0) {
        return rock
    }
    return Set(rock.map { $0.moveLeft() })
}

func moveRight(_ rock: Rock) -> Rock {
    if rock.map({ $0.x }).contains(6) {
        return rock
    }
    return Set(rock.map { $0.moveRight() })
}

func moveDown(_ rock: Rock) -> Rock {
    Set(rock.map { $0.moveDown() })
}

func moveUp(_ rock: Rock) -> Rock {
    Set(rock.map { $0.moveUp() })
}

func printRock(_ rock: Rock) {
    let maxY = rock.map { $0.y }.max()!
    for y in 0 ... maxY {
        var row = ""
        for x in 0..<7 {
            if rock.contains(Point(x: x, y: y)) {
                row += "#"
            }
            else {
                row += " "
            }
        }
        print(row)
    }
}
func partOne() -> CustomStringConvertible {
    var grid: Rock = Set((0..<7).map { Point(x: $0, y: 0) })
    print(grid)
    var i = 0
    var top = 0
    for t in 0 ..< 2022 {
        var rock = getfallingRock(t%5,top+4)
        while true {
            if input[i] == "<" {
                rock = moveLeft(rock)
                if !rock.intersection(grid).isEmpty {
                    rock = moveRight(rock)
                }
            }
            else if input[i] == ">" {
                rock = moveRight(rock)
                if !rock.intersection(grid).isEmpty {
                    rock = moveLeft(rock)
                }
            }
            else {
                fatalError(input[i])
            }
            i = (i+1)%input.count
            rock = moveDown(rock)
            
            if !rock.intersection(grid).isEmpty {
                rock = moveUp(rock)
                grid = grid.union(rock)
                let maxTop = grid.map { $0.y }.max()!
                top = maxTop
                break
            }
        }
    }
    return top
}

func partTwo() -> CustomStringConvertible {
    return 0
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
