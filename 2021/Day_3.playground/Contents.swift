import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)

func partOne() -> Int {

    let given = input.map { i in
        return i.map { $0 }
    }

    var gamma: [Int] = Array.init(repeating: 0, count: given[0].count)
    var ep: [Int] = Array.init(repeating: 0, count: given[0].count)
    for i in 0 ..< given[0].count {
        let c = given.map {  $0[i] }
        let ones = c.filter { $0 == "1" }.count
        let zeros = c.filter { $0 == "0" }.count
        if ones > zeros {
            gamma[i] = 1
            ep[i] = 0
        }
        else {
            gamma[i] = 0
            ep[i] = 1
        }
    }

    return Int(gamma.map { String($0) }.joined(),radix: 2)! *
    Int.init(ep.map { String($0) }.joined(),radix: 2)!
}

func partTwo() -> Int {
    let given = input.map { i in
        return i.map { $0 }
    }

    func loop(_ g: [[String.Element]], _ i: Int, _ least: Bool) -> Int {
        let c = g.map {  $0[i] }
        let ones = c.filter { $0 == "1" }.count
        let zeros = c.filter { $0 == "0" }.count

        var nextG: [[String.Element]] = []

        if ones == zeros {
            let r = least ? g.filter { $0[i] == "0" } : g.filter { $0[i] == "1" }
            return Int.init(r.map { String($0) }.joined(),radix: 2)!
        }
        else if ones > zeros {
            nextG = least ? g.filter { $0[i] == "0" } : g.filter { $0[i] == "1" }
        }
        else if ones < zeros {
            nextG = least ? g.filter { $0[i] == "1" } : g.filter { $0[i] == "0" }
        }
        return loop(nextG, i + 1, least)
    }

    return loop(given, 0, false) * loop(given, 0, true)
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

