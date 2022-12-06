import Cocoa

var input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines)

func check(_ line: String, _ max: Int) -> Int {
    var i = 0

    while i < line.count - max {
        let s = line.index(line.startIndex, offsetBy: i)
        let e = line.index(line.startIndex, offsetBy: i+max)
        let c = line[s ..< e]
        if Set(c).count == c.count {
            break
        }
        i += 1
    }

    return i+max
}

func partOne() -> Int {
    return check(input,4)
}

func partTwo() -> Int {
    return check(input,14)
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
