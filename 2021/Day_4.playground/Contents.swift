import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)

let given = input[0].split(separator: ",").map { Int(String($0))! }

var tmpBoard = Array(input[2 ..< input.count])
var board: [[Int]] = []


struct Point: CustomStringConvertible, Equatable, Hashable {
    var x: Int
    var y: Int

    var description: String {
        get {
            return "X: \(self.x) Y: \(self.y)"
        }
    }
}

var boards: [[Point: Int]] = []

tmpBoard.split(separator: "").enumerated().forEach { (i, ele) in
    var board: [Point: Int] = [:]
    let b = ele.map {
        $0.split(separator: " ").map { Int($0)! }
    }
    b.enumerated().forEach { r, rV in
        rV.enumerated().forEach { c, cV in
            board[Point.init(x: r, y: c)] = cV
        }
    }
    boards.insert(board, at: i)
}

//print("full board: \(boards)")

func partOne() -> Int {
    var marked: [Int] = []

    func draw(_ board: [Point: Int]) -> Bool {
        var pass = false
        for x in 0 ... 4 {
            var col: [Int] = []
            for y in 0 ... 4 {
                let v = board[Point(x: x, y: y)]!
                col.append(v)
            }
            if col.filter({ marked.contains($0) }).count == col.count {
                pass = true
                break
            }
        }

        for y in 0 ... 4 {
            var row: [Int] = []
            for x in 0 ... 4 {
                let v = board[Point(x: x, y: y)]!
                row.append(v)
            }
            if row.filter({ marked.contains($0) }).count == row.count {
                pass = true
                break
            }
        }

        return pass
    }

    var result = 0
    var win: Set<Int> = []

    for g in given {
        marked.append(g)
        var canBreak = false
        var index = 0
        while index < boards.count {
            let board = boards[index]
            if draw(board) {
                win.insert(index)

                let sum = board.values.filter {
                    !marked.contains($0)
                }.reduce(0, +)
                result = sum * g
                canBreak = true
                break
            }
            index += 1
        }

        if canBreak {
            break
        }
    }

    return result
}

func partTwo() -> Int {
    var marked: [Int] = []

    func draw(_ board: [Point: Int]) -> Bool {
        var pass = false
        for x in 0 ... 4 {
            var col: [Int] = []
            for y in 0 ... 4 {
                let v = board[Point(x: x, y: y)]!
                col.append(v)
            }
            if col.filter({ marked.contains($0) }).count == col.count {
                pass = true
                break
            }
        }

        for y in 0 ... 4 {
            var row: [Int] = []
            for x in 0 ... 4 {
                let v = board[Point(x: x, y: y)]!
                row.append(v)
            }
            if row.filter({ marked.contains($0) }).count == row.count {
                pass = true
                break
            }
        }

        return pass
    }

    var result = 0
    var win: Set<Int> = []
    for g in given {
        marked.append(g)
        var canBreak = false
        var index = 0
        while index < boards.count {
            let board = boards[index]
            if draw(board) {
                win.insert(index)

                let sum = board.values.filter {
                    !marked.contains($0)
                }.reduce(0, +)
                result = sum * g

                if win.count == boards.count {
                    canBreak = true
                    break
                }
            }
            index += 1
        }

        if canBreak {
            break
        }
    }

    return result
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

enum PuzzleInput: String {
    case input = "input"
    case test  = "test_input"
}

func load(_ input: PuzzleInput) -> String {
    switch input {
    case .input:
        return load(file: "input")
    default:
        return load(file: "test_input")
    }
}

func load(file name: String) -> String {
    guard let url = Bundle.main.url(forResource: name, withExtension: "txt") else {
        fatalError("Cannot load file with name :\(name)")
    }

    guard let content = try? String(contentsOf: url, encoding: .utf8) else {
        fatalError("Cannot convert file contents to string for file :\(name)")
    }

    return content
}

