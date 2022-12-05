import Cocoa

let input = load(.input, runFromTerminal:true).trimmingCharacters(in: .newlines)

struct Move {
    let count: Int
    let from: Int
    let to: Int
    
    init(_ line: String) {
        let com = line.components(separatedBy: " ")
        count = Int(com[1])!
        from = Int(com[3])!
        to = Int(com[5])!
    }
}

let com = input.components(separatedBy: "\n\n")
let moves = com[1].components(separatedBy: .newlines).map { Move.init($0) }

func parseSteps(_ line:String) -> [Int: [String]] {
    var steps: [Int: [String]] = [:]
    for row in line.components(separatedBy: .newlines) {
        for (i,c) in row.enumerated() {
            if c.isLetter {
                let num = (i/4)+1
                steps[num, default: []].insert(String(c), at: 0)
            }
        }
    }
    return steps
}

func rearrange(_ steps: [Int: [String]], _ isReversed: Bool) -> String {
    var steps = steps
    for move in moves {
        let cur = steps[move.from]!
        let old = cur.dropLast(move.count)
        steps[move.from]?.removeAll()
        steps[move.from]! += old
        var new = Array(cur[cur.count - move.count ..< cur.count])
        if isReversed {
            new = new.reversed()
        }
        steps[move.to]! += new
    }
    
    return steps.keys.sorted().compactMap { steps[$0]?.last }.joined()
}

func partOne() -> String {
    rearrange(parseSteps(com[0]),true)
}

func partTwo() -> String {
    rearrange(parseSteps(com[0]),false)
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
