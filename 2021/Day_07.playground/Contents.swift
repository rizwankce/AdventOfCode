import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: ",").map { Int($0)! }

print(input)

func partOne() -> Int {
    let sort = input.sorted()
    var result: [Int] = []
    for i in sort.first! ... sort.last! {
        let f = input.map { c in
            abs(c - i)
        }
        result.append(f.reduce(0, +))
    }
    return result.min()!
}

func partTwo() -> Int {
    let sort = input.sorted()
    var result: [Int] = []
    for i in sort.first! ... sort.last! {
        let f = input.map { c -> Int in
            return (0 ... abs(c - i)).reduce(0, +)
        }
        result.append(f.reduce(0, +))
    }
    return result.min()!
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

