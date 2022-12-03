import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

func ascii(_ char: String) -> UInt32 {
    char.unicodeScalars.first!.value
}

func score(_ char: String) -> UInt32 {
    if "a" <= char && char <= "z" {
        return ascii(char) - ascii("a") + 1
    }
    return ascii(char) - ascii("A") + 1 + 26
}

func partOne() -> Int {
    var total = 0
    for line in input {
        assert(line.count % 2 == 0)
        let middle = line.index(line.startIndex, offsetBy: line.count / 2)
        let left = Set(line[line.startIndex ..< middle])
        let right = Set(line[middle ..< line.endIndex])
        let com = left.intersection(right)
        assert(com.count == 1)
        total += Int(score(String(com.first!)))
    }
    return total
}

func partTwo() -> Int {
    assert(input.count % 3 == 0)
    var total = 0
    var s = 0
    var e = 2
    while e < input.count {
        let group = Array(input[s ... e])
        let first = Set(group[0])
        let second = Set(group[1])
        let third = Set(group[2])
        let com = first.intersection(second).intersection(third).first!
        total += Int(score(String(com)))
        s += 3
        e += 3
    }
    return total
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
