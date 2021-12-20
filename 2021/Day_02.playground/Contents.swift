import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)

func partOne() -> Int {
    var h = 0
    var d = 0

    input.forEach { $0
        let command = $0.split(separator: " ")
        let move = Int(command[1])!
        if command[0] == "forward" {
            h += move
        }
        else if command[0] == "up" {
            d -= move
        }
        else if command[0] == "down" {
            d += move
        }
    }

    return h * d
}

func partTwo() -> Int {
    var h = 0
    var d = 0
    var a = 0

    input.forEach { $0
        let command = $0.split(separator: " ")
        let move = Int(command[1])!
        if command[0] == "forward" {
            h += move
            d += a == 0 ? 0 : a * move
        }
        else if command[0] == "up" {
            a -= move
        }
        else if command[0] == "down" {
            a += move
        }
    }

    return h * d
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

