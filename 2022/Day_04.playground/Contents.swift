import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

extension ClosedRange {
    func contains(_ other: ClosedRange) -> Bool {
        other.clamped(to: self) == other
    }
}
var p1 = 0
var p2 = 0
for line in input {
    // 2-6,4-8
    let com = line.components(separatedBy: ",")
    let left = com[0].split(separator: "-")
    let right = com[1].split(separator: "-")
    let l = Int(left[0])! ... Int(left[1])!
    let r = Int(right[0])! ... Int(right[1])!
    if l.contains(r) || r.contains(l) {
        p1 += 1
    }
    if l.overlaps(r) {
        p2 += 1
    }
}

func partOne() -> Int {
    p1
}

func partTwo() -> Int {
    p2
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
