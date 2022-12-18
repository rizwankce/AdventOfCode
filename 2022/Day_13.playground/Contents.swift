import Cocoa

let input = load(.input, runFromTerminal:true).trimmingCharacters(in: .newlines).components(separatedBy: "\n\n")
print(input)

/**
 If both values are integers, the lower integer should come first. If the left integer is lower than the right integer, the inputs are in the right order. If the left integer is higher than the right integer, the inputs are not in the right order. Otherwise, the inputs are the same integer; continue checking the next part of the input.
 If both values are lists, compare the first value of each list, then the second value, and so on. If the left list runs out of items first, the inputs are in the right order. If the right list runs out of items first, the inputs are not in the right order. If the lists are the same length and no comparison makes a decision about the order, continue checking the next part of the input.
 If exactly one value is an integer, convert the integer to a list which contains that integer as its only value, then retry the comparison. For example, if comparing [0,0,0] and 2, convert the right value to [2] (a list containing 2); the result is then found by instead comparing [0,0,0] and [2].
 **/

enum ComparisonResult {
    case right
    case wrong
    case continue_
}

func parse(_ line: inout Substring) -> Array<Any> {
    var itms: Array<Any> = []
    while !line.isEmpty {
        if line.hasPrefix("[") {
            line = line.dropFirst()
            let childs = parse(&line)
            itms.append(childs)
        }
        else if line.hasPrefix("]") {
            line = line.dropFirst()
            break
        }
        else if line.hasPrefix(",") {
            line = line.dropFirst()
        }
        else {
            var num = ""
            for char in line {
                if !char.isWholeNumber {
                    break
                }
                num.append(char)
            }
            line = line.dropFirst(num.count)
            let n = Int(String(num))!
            itms.append(n)
        }
    }

    return itms
}

func compare(_ left: Any, _ right: Any) -> ComparisonResult {
    let lType = type(of: left)
    let rType = type(of: right)
    if lType == Int.self && rType == Int.self {
        let l = left as! Int
        let r = right as! Int
        if l < r {
            return .right
        }
        else if l > r {
            return .wrong
        }
        else {
            return .continue_
        }
    }
    else if lType == Array<Any>.self && rType == Array<Any>.self {
        let l = left as! Array<Any>
        let r = right as! Array<Any>
        
        var i = 0
        while i < l.count && i < r.count {
            let r = compare(l[i],r[i])
            if r != .continue_ {
                return r
            }
            i += 1
        }
        
        if i == l.count && i < r.count {
            return .right
        }
        else if i == r.count && i < l.count {
            return .wrong
        }
        else {
            return .continue_
        }
    }
    else if lType == Array<Any>.self && rType == Int.self {
        return compare(left,[right])
    }
    else if lType == Int.self && rType == Array<Any>.self {
        return compare([left],right)
    }
    return .wrong
}

var indices: [Int] = []
var parsed: Array<Any> = []
for (i,line) in input.enumerated() {
    var com = line.split(separator: "\n")
    let l = parse(&com[0])
    let r = parse(&com[1])
    parsed.append(l)
    parsed.append(r)
    assert(com[0].count == 0)
    assert(com[1].count == 0)
    let test = compare(l,r)
    print(test,i+1)
    if test == .right {
        indices.append(i+1)
    }
}

var new = "[[2]]\n[[6]]".split(separator: "\n")
var packets = [parse(&new[0]), parse(&new[1])]
parsed.append(packets[0])
parsed.append(packets[1])
parsed.sort { l,r in
    compare(l, r) == .right || compare(l, r) == .continue_
}

var idx : [Int] = []
for (i,arr) in parsed.enumerated() {
    print(i,arr)
    if type(of: arr) == Array<Any>.self {
        if let c = arr as? Array<Array<Array<Int>>> {
            let t = c.first?.first ?? []
            if t.count == 1 {
                if c.first?.first?.first == 2 ||
                    c.first?.first?.first == 6 {
                    idx.append(i+1)
                }
            }
        }
    }
}

func partOne() -> CustomStringConvertible {
    return indices.reduce(0, +)
}

func partTwo() -> CustomStringConvertible {
    return idx.reduce(1, *)
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
