import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: "\n\n")

let template = input[0].map { String($0) }

var pair: [String: String] = [:]

input[1].components(separatedBy: .newlines).forEach { ins in
    let p = ins.components(separatedBy: " -> ")
    let a = p[0]
    let b = p[1]
    pair[a] = b
}

extension String {
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
}

func partOne() -> Int {
    var temp = template

    for _ in (1...10) {
        var newTemp: String = ""
        for (c,n) in zip(temp, temp.dropFirst()) {
            let next = String(c+n)
            if let ins = pair[next] {
                if newTemp.isEmpty {
                    newTemp.append(c + ins + n)
                }
                else {
                    newTemp.append(ins + n)
                }
            }
        }
        temp = newTemp.map { String($0) }
    }

    var count: [String: Int] = [:]

    for char in temp {
        count[char, default: 0] += 1
    }

    return count.values.max()! - count.values.min()!
}

func partTwo() -> Int {
    var count: [String: Int] = [:]

    for i in 0 ..< template.count - 1  {
        let p = template[i] + template[i+1]
        count[p, default: 0] += 1
    }

    for _ in (1...40) {
        var newPairs : [String: Int] = [:]
        for (key, value) in count {
            guard let ins = pair[key] else {
                fatalError("This should never happen")
            }

            let left = key[0] + ins
            let right = ins + key[1]
            newPairs[left, default: 0] += value
            newPairs[right, default: 0] += value
        }
        count = newPairs
    }

    var result: [Character: Int] = [:]

    for (k,v) in count {
        for char in k {
            if result[char] != nil {
                result[char]! += v
            }
            else {
                result[char] = v
            }
        }
    }

    result[Character(template.first!)]! += 1
    result[Character(template.last!)]! += 1

    result = result.mapValues { $0 / 2 }

    return result.values.max()! - result.values.min()!
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

