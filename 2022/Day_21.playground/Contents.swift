import Cocoa

let input = load(.input, runFromTerminal:true).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)
var mValues: [String: Int] = [:]
var mExpressions: [String: [String]] = [:]

for line in input {
    let com = line.components(separatedBy: " ")
    let m = String(com[0].prefix(com[0].count-1))
    let v = Int(com[1])
    if v != nil {
        mValues[m] = v!
    }
    else {
        mExpressions[m] = com.suffix(3)
    }
}

func solve(_ mExpressions: [String: [String]], _ mValues: [String: Int
]) -> (Int,Int) {
    var mValues = mValues
    var pos = 0
    while true {
        for exp in mExpressions {
            let val = exp.value
            let l = val[0]
            let r = val[2]
            if [l,r].filter({ mValues.keys.contains($0) }).count == 2 {
                var ans = 0
                switch val[1] {
                case "+": ans = mValues[l]! + mValues[r]!
                case "-": ans = mValues[l]! - mValues[r]!
                case "*": ans = mValues[l]! * mValues[r]!
                case "/": ans = mValues[l]! / mValues[r]!
                case "=": break
                default: fatalError("unknown")
                }
                mValues[exp.key] = ans
                
                if exp.key == "root" {
                    pos = mValues[r]! - mValues[l]!
                }
            }
        }
        if mValues.keys.contains("root") {
            break
        }
    }
    return (mValues["root"]!,pos)
}

func partOne() -> CustomStringConvertible {
    return solve(mExpressions, mValues).0
}

func partTwo() -> CustomStringConvertible {
    let old = mExpressions["root"]!
    mExpressions["root"] = [old[0],"=",old[2]]
    var low = 10
    var high = 1_000_000_000_000_000

    var i = 0
    while true {
        let mid = (low + high) / 2
        mValues["humn"] = mid
        let pos = solve(mExpressions, mValues).1
        if pos == 0 {
            i = mid
            break
        }
        else if pos < 1 {
            low = mid
        }
        else {
            high = mid
        }
    }
    return i
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
