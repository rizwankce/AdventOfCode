import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)

func runCRT() -> (Int,String) {
    var i = 0
    var x = 1
    var ins: [Int: Int] = [:]
    var checks: [Int] = [20,60,100,140,180,220]
    var strength: [Int] = []
    var all:[Int] = []
    var crt: [String] = Array.init(repeating: "", count: 240)
    var sprIndex = 0
    var crtIndex = 0
    
    for cycle in 1...240 {
        all.append(x)
        let idx = crtIndex >= 40 ? crtIndex % 40 : crtIndex
        if (sprIndex..<sprIndex+3).contains(idx) {
            crt[crtIndex] = "#"
        }
        else {
            crt[crtIndex] = "."
        }
        
        crtIndex += 1
        
        if checks.contains(cycle) {
            strength.append(cycle * x)
        }

        if ins.keys.contains(cycle) {
            x += ins[cycle, default: 0]
            sprIndex = x-1
        }
        else {
            if input.count > i {
                let cur = input[i]
                i += 1
                if cur == "noop" {

                }
                else if cur.contains("addx") {
                    let com = Int(cur.components(separatedBy: " ")[1])!
                    ins[cycle+1] = com
                }
            }
        }
    }
    
    var result: String = ""
    for (i,char) in crt.enumerated() {
        if i % 40 == 0 {
            result.append("\n")
        }
        result.append(char == "#" ? char : " ")
    }
    
    return (strength.reduce(0, +),result)
}

func partOne() -> CustomStringConvertible {
    runCRT().0
}

func partTwo() -> CustomStringConvertible {
    runCRT().1
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
