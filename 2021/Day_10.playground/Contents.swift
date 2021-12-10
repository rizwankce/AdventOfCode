import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: .newlines).map { $0.map { String($0) } }

//print(input)

func partOne() -> Int {
    var illegal: [String] = []

    for line in input {
        var stack: [String] = []
        for char in line {
            if char == "[" || char == "(" || char == "{" || char == "<" {
                stack.append(char)
            }
            else {
                if let pop = stack.popLast() {
                    if pop == "[" && char != "]" {
                        illegal.append(char)
                        break
                    }
                    else if pop == "(" && char != ")" {
                        illegal.append(char)
                        break
                    }
                    else if pop == "{" && char != "}" {
                        illegal.append(char)
                        break
                    }
                    else if pop == "<" && char != ">" {
                        illegal.append(char)
                        break
                    }
                }
            }
        }
    }

    let points: [String: Int] = [
        ")": 3,
        "]": 57,
        "}": 1197,
        ">": 25137
    ]

    return illegal.map { points[$0]! }.reduce(0, +)
}

func partTwo() -> Int {
    var incomplete: [[String]] = []
    for line in input {
        var stack: [String] = []
        var illegal = false
        for char in line {
            if char == "[" || char == "(" || char == "{" || char == "<" {
                stack.append(char)
            }
            else {
                if let pop = stack.popLast() {
                    if pop == "[" && char != "]" {
                        illegal = true
                    }
                    else if pop == "(" && char != ")" {
                        illegal = true
                    }
                    else if pop == "{" && char != "}" {
                        illegal = true
                    }
                    else if pop == "<" && char != ">" {
                        illegal = true
                    }
                }
            }
        }

        if !illegal {
            incomplete.append(line)
        }
    }

    var scores: [Int] = []
    let points: [String: Int] = [
        ")": 1,
        "]": 2,
        "}": 3,
        ">": 4
    ]

    for line in incomplete {
        var stack: [String] = []
        for char in line {
            if char == "[" || char == "(" || char == "{" || char == "<" {
                stack.append(char)
            }
            else {
                _ = stack.popLast()
            }
        }

        var complete: [String] = []

        for char in stack {
            if char == "{" {
                complete.append("}")
            }
            else if char == "(" {
                complete.append(")")
            }
            else if char == "[" {
                complete.append("]")
            }
            else if char == "<" {
                complete.append(">")
            }
        }
        complete = complete.reversed()

        var score = 0
        for char in complete {
            score = (score * 5) + points[char]!
        }
        scores.append(score)
    }

    return scores.sorted()[scores.middleIndex]
}

extension Array {

    var middleIndex: Int {
        return (self.isEmpty ? self.startIndex : self.count - 1) / 2
    }
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

