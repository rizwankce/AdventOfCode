import Cocoa

let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

//print(input)

struct Segment {
    let left: [String]
    let right: [String]
}

var segments: [Segment] = []
input.forEach { i in
    let r = i.components(separatedBy:" | ")
    let left = r[0].components(separatedBy: " ")
    let right = r[1].components(separatedBy: " ")
    let seg = Segment.init(left: left, right: right)
    segments.append(seg)
}


func partOne() -> Int {
    var result = 0

    let notes: [Int: Int] = [
        1: 2,
        4: 4,
        7: 3,
        8: 7
    ]

    for seg in segments {
        let test = seg.right
        for t in test {
            result += notes.values.contains(t.count) ? 1 : 0
        }
    }

    return result
}

func partTwo() -> Int {
    segments.map {
        solve($0)
    }.reduce(0, +)
}

func solve(_ seg: Segment) -> Int {
    let notes: [Int: Int] = [
        1: 2,
        4: 4,
        7: 3,
        8: 7
    ]

    var config: [Int: Set<Character>] = [:]

    let test = seg.right + seg.left

    for t in test {
        if notes.values.contains(t.count) {
            let key = notes.filter { $0.value == t.count }.first!.key
            config[key] = Set(t.map { $0 })
        }
    }


    // find 9
    let t9 = config[4]!.union(config[7]!)

    for t in test {
        let set = Set(t.map { $0 })
        if !config.values.contains(set) {
            if set.count == 6 && t9.symmetricDifference(set).count == 1 {
                config[9] = set
            }
        }
    }


    // find 6
    let t1 = config[1]!

    for t in test {
        let set = Set(t.map { $0 })
        if !config.values.contains(set) {
            if set.count == 6 && t1.union(set).count == 7 {
                config[6] = set
            }
        }
    }

    // find 0
    for t in test {
        let set = Set(t.map { $0 })
        if !config.values.contains(set) {
            if set.count == 6 {
                config[0] = set
            }
        }
    }

    // find 5
    let t6 = config[6]!

    for t in test {
        let set = Set(t.map { $0 })
        if !config.values.contains(set) {
            if set.count == 5 && t6.symmetricDifference(set).count == 1 {
                config[5] = set
            }
        }
    }

    // find 2
    let t5 = config[5]!

    for t in test {
        let set = Set(t.map { $0 })
        if !config.values.contains(set) {
            if set.count == 5 && t5.union(set).count == 7 {
                config[2] = set
            }
        }
    }

    // find 3

    for t in test {
        let set = Set(t.map { $0 })
        if !config.values.contains(set) {
            if set.count == 5 {
                config[3] = set
            }
        }
    }

    let right = seg.right
    var output: [Int] = []
    for t in right {
        let set = Set(t.map { $0 })
        if let num = config.filter({ $0.value == set }).first {
            output.append(num.key)
        }
    }

    return Int(output.map(String.init).joined())!
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
