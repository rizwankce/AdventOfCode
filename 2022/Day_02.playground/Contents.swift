import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)


enum Win {
    case success
    case failed
    case draw
}

func partOne() -> Int {
    var scores: [Int] = []
    
    func play(_ left: String, _ right: String) -> Win {
        if left == "A" && right == "X" {
            return .draw
        }
        
        if left == "B" && right == "Y" {
            return .draw
        }
        
        if left == "C" && right == "Z" {
            return .draw
        }
        
        if right == "X" && left == "C" {
            return .success
        }
        
        if right == "Z" && left == "B" {
            return .success
        }
        
        if right == "Y" && left == "A" {
            return .success
        }
        return .failed
    }
    
    for line in input {
        var total = 0
        let com = line.components(separatedBy: " ")
        let left = com[0]
        let right = com[1]
        
        switch right {
        case "X": total += 1
        case "Y": total += 2
        case "Z": total += 3
        default:
            break
        }
        
        switch play(left, right) {
        case .draw: total += 3
        case .success: total += 6
        case .failed: total += 0
        }
        scores.append(total)
    }

    return scores.reduce(0, +)
}

func partTwo() -> Int {
    var scores: [Int] = []
    
    func play(_ left: String, _ right: String) -> Int {
        
        switch right {
        case "X":
            if left == "A" {
                return 3
            }
            if left == "B" {
                return 1
            }
            if left == "C" {
                return 2
            }
            
        case "Y":
            if left == "A" {
                return 1
            }
            if left == "B" {
                return 2
            }
            if left == "C" {
                return 3
            }
        case "Z":
            if left == "A" {
                return 2
            }
            if left == "B" {
                return 3
            }
            if left == "C" {
                return 1
            }
        default: break
        }
        
        return 0
    }
    
    for line in input {
        var total = 0
        let com = line.components(separatedBy: " ")
        let left = com[0]
        let right = com[1]
        
        switch right {
        case "X": total += 0
        case "Y": total += 3
        case "Z": total += 6
        default:
            break
        }
        
        total += play(left, right)
        scores.append(total)
    }

    return scores.reduce(0, +)
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
